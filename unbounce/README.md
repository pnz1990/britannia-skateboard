# Unbounce Deployment Guide

## Files Overview

| File | Purpose | Where in Unbounce |
|------|---------|-------------------|
| `unbounce-css.html` | All CSS styles | Stylesheets → Head |
| `unbounce-html.html` | HTML content | Custom HTML block |
| `unbounce-js.html` | JavaScript | Javascripts → Before Body End Tag |

## Step-by-Step Deployment

### 1. Page Setup
1. In Unbounce, create a new **Blank** landing page
2. Delete all default elements on the page
3. Set page width to **1440px** (desktop) / **320px** (mobile)
4. Set page background to **transparent** or **#ffffff**
5. **Critical**: Set the page/section height to at least **8000px** — Unbounce clips content to the page height. Your custom HTML block is `position: absolute` inside Unbounce's container, so the container must be tall enough
6. Disable "Auto Scale" if the option is available

### 2. Add Custom CSS (includes font imports)
1. Go to **Javascripts & Stylesheets** (bottom-left of builder) → **Stylesheets** → **Add New Stylesheet**
2. Set placement to **Head**
3. Copy the entire contents of `unbounce-css.html` and paste it (includes `<link>` tags for fonts and `<style>` wrapper — Unbounce does NOT add these automatically)
4. Save

### 3. Add the HTML Block
1. In the Unbounce builder, add a **Custom HTML** element
2. Make it **full width** (1440px wide) and set height to **auto** or very tall (8000px+)
3. Position it at **top: 0, left: 0**
4. Double-click the Custom HTML block to edit
5. Copy the entire contents of `unbounce-html.html` and paste it
6. Save

### 4. Add JavaScript
1. Go to **Javascripts & Stylesheets** → **Javascripts** → **Add New Javascript**
2. Set placement to **Before Body End Tag**
3. Copy the entire contents of `unbounce-js.html` and paste it (includes `<script>` wrapper — Unbounce does NOT add this automatically)
4. Save

### 5. Mobile Variant
1. Switch to the **Mobile** variant in Unbounce
2. Ensure the Custom HTML block is also full-width (320px) on mobile
3. The CSS includes responsive media queries that will handle the layout automatically

## Key Differences from GitHub Pages Version

- `position: fixed` → `position: absolute` (fixed positioning doesn't work inside Unbounce's container)
- All CSS selectors scoped under `.bsc-page` to avoid conflicts with Unbounce's own styles
- `html`/`body` styles remapped to the `.bsc-page` wrapper div
- Video background is `absolute` within the wrapper instead of `fixed` to viewport
- Header navigation is `sticky` instead of `fixed`

## Troubleshooting

- **Content cut off**: Increase the Custom HTML block height or the page height in Unbounce
- **Styles not applying**: Make sure the CSS stylesheet placement is set to "Head"
- **JS not working**: Make sure placement is "Before Body End Tag"
- **Fonts not loading**: Verify the external stylesheet URLs are added correctly
- **Video not showing**: The video background uses absolute positioning — ensure the `.bsc-page` wrapper has enough height
- **Layout looks squished**: Disable Unbounce's autoscale feature or ensure the Custom HTML block is full page width

## Hosting Assets on Unbounce

Currently, some assets are served from GitHub Pages and an external site. To host everything on Unbounce's CDN instead:

### Assets to migrate

| File | Size | Currently hosted on |
|------|------|---------------------|
| `logo.png` | 458KB | GitHub Pages |
| `aerial.jpg` | 312KB | GitHub Pages |
| `tennis-texture.jpeg` | 1.2MB | GitHub Pages |
| `videoplayback.mp4` | 5.1MB | GitHub Pages |
| `britannia_logo(1).png` | small | britanniacentre.org |

The 11 images on `d9hhrg4mnvzow.cloudfront.net` are **already on Unbounce's CDN** — no action needed.

### Step 1: Upload images via Unbounce Image Manager

1. In the Unbounce builder, click **Images** in the left panel (or drag an Image element)
2. Click **Upload** and add these files from the project root:
   - `logo.png`
   - `aerial.jpg`
   - `tennis-texture.jpeg`
3. After each upload, **right-click the image → Copy image URL** — it will look like `https://d9hhrg4mnvzow.cloudfront.net/...`
4. Save each URL — you'll need them in Step 3

### Step 2: Upload the video

Unbounce's image manager doesn't support `.mp4` files. Options:

- **Option A** — Upload `videoplayback.mp4` to YouTube (unlisted) or Vimeo, use that URL
- **Option B** — Upload to a free CDN (e.g., Cloudinary free tier)
- **Option C** — Keep on GitHub Pages (already working at `https://pnz1990.github.io/britannia-skateboard/videoplayback.mp4`)

### Step 3: Replace URLs using the helper script

1. Open `unbounce/replace-urls.sh`
2. Paste each new CDN URL into the corresponding variable:
   ```bash
   LOGO_URL="https://d9hhrg4mnvzow.cloudfront.net/your-domain/logo_xxxxx.png"
   AERIAL_URL="https://d9hhrg4mnvzow.cloudfront.net/your-domain/aerial_xxxxx.jpg"
   TENNIS_TEXTURE_URL="https://d9hhrg4mnvzow.cloudfront.net/your-domain/tennis_xxxxx.jpeg"
   VIDEO_MP4_URL="https://your-video-host.com/videoplayback.mp4"
   BRITANNIA_LOGO_URL="https://d9hhrg4mnvzow.cloudfront.net/your-domain/britannia_logo_xxxxx.png"
   ```
3. Run the script:
   ```bash
   cd unbounce
   bash replace-urls.sh
   ```
4. Re-paste the updated `unbounce-css.html` and `unbounce-html.html` into Unbounce

Leave any variable empty to skip that replacement (keeps the current URL).

---

## Testing
1. Use Unbounce's **Preview** to test before publishing
2. Test on both desktop and mobile viewports
3. Check that smooth scrolling, animations, and video background work
