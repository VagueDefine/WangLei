import { QuartzConfig } from "./quartz/cfg"
import * as Plugin from "./quartz/plugins"

/**
 * Quartz 4 Configuration
 *
 * See https://quartz.jzhao.xyz/configuration for more information.
 */
const config: QuartzConfig = {
  configuration: {
    pageTitle: "Quartz 4",
    pageTitleSuffix: "",
    enableSPA: false,
    enablePopovers: true,
    analytics: {
      provider: "plausible",
    },
    locale: "en-US",
    baseUrl: "vaguedefine.github.io/WangLei/",
    ignorePatterns: [
      "private", 
      "**/000templates", 
      "**/000Excaildraw",
      "**/.obsidian", 
      "**/.git", 
      "**/.gitattributes",
      "**/.gitignore",
      "**/.trash"
    ],
    defaultDateType: "modified",
    theme: {
      fontOrigin: "googleFonts",
      cdnCaching: true,
      typography: {
        header: "Lexend",
        body: "Inter",
        code: "JetBrains Mono",
      },
      colors: {
        lightMode: {
          light: "#faf4ed",
          lightgray: "#cecacd",
          gray: "#9893a5",
          darkgray: "#575279",
          dark: "#26233a",
          secondary: "#d7827e",
          tertiary: "#56949f",
          highlight: "rgba(223, 218, 217, 0.5)",
          textHighlight: "#cecacd",
        },
        darkMode: {
          light: "#26233a",
          lightgray: "#42404f",
          gray: "#6e6a86",
          darkgray: "#e0def4",
          dark: "#faf4ed",
          secondary: "#ebbcba",
          tertiary: "#56949f",
          highlight: "rgba(64, 61, 82, 0.5)",
          textHighlight: "#524f67",
        },
      },
    },
  },
  plugins: {
    transformers: [
      Plugin.FrontMatter(),
      Plugin.CreatedModifiedDate({
        priority: ["frontmatter", "git", "filesystem"],
      }),
      Plugin.SyntaxHighlighting({
        theme: {
          light: "github-light",
          dark: "github-dark",
        },
        keepBackground: false,
      }),
      Plugin.ObsidianFlavoredMarkdown({ enableInHtmlEmbed: false }),
      Plugin.GitHubFlavoredMarkdown(),
      Plugin.TableOfContents(),
      Plugin.CrawlLinks({ markdownLinkResolution: "relative" }),
      Plugin.Description(),
      Plugin.Latex({ renderEngine: "mathjax" }),
    ],
    filters: [Plugin.RemoveDrafts()],
    emitters: [
      Plugin.AliasRedirects(),
      Plugin.ComponentResources(),
      Plugin.ContentPage(),
      Plugin.FolderPage(),
      Plugin.TagPage(),
      Plugin.ContentIndex({
        enableSiteMap: true,
        enableRSS: true,
      }),
      Plugin.Assets(),
      Plugin.Static(),
      Plugin.Favicon(),
      Plugin.NotFoundPage(),
      // Comment out CustomOgImages to speed up build time
      // Plugin.CustomOgImages(),
    ],
  },
}

export default config
