// Fit-check one revealjs slide by screenshotting it at native deck size.
//
// Usage:
//   node .claude/scripts/slide-shot.mjs <index.html> <anchor|#index> <out.png> [--all-fragments]
//
// Renders the deck first (`quarto render …`), then point this at the built
// _site/…/index.html with an ABSOLUTE path. Navigate by anchor id
// (`## Title {#anchor}` → pass `anchor`) — robust as slides move. Prints
// {id, num, scrollH, clientH}; a slide fits when scrollH === clientH.
// See .claude/rules/slides.md §1.
//
// Sandbox paths: Playwright is the global install at /opt/node22/…; Chromium
// is preinstalled at /opt/pw-browsers (PLAYWRIGHT_BROWSERS_PATH). Adjust the
// import below if you run this outside this environment.
import { chromium } from '/opt/node22/lib/node_modules/playwright/index.mjs';

const [html, target, out] = process.argv.slice(2);
const allFragments = process.argv.includes('--all-fragments');
const W = 1280, H = 720;

const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: W, height: H }, deviceScaleFactor: 2 });
const url = 'file://' + html + (target.startsWith('#') ? '#/' + target.slice(1) : '#/' + target);
await page.goto(url, { waitUntil: 'networkidle' });
await page.waitForFunction('window.Reveal && window.Reveal.isReady && window.Reveal.isReady()');
await page.waitForTimeout(400);
if (allFragments) {
  // advance through every fragment on the current slide
  await page.evaluate(async () => {
    let guard = 0;
    while (window.Reveal.availableFragments().next && guard++ < 50) {
      window.Reveal.nextFragment();
      await new Promise(r => setTimeout(r, 60));
    }
  });
  await page.waitForTimeout(300);
}
await page.screenshot({ path: out });
const info = await page.evaluate(() => {
  const s = window.Reveal.getCurrentSlide();
  return { id: s.id, num: window.Reveal.getSlidePastCount() + 1,
           scrollH: s.scrollHeight, clientH: s.clientHeight };
});
console.log(JSON.stringify(info));
await browser.close();
