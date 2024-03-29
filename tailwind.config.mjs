import defaultTheme from "tailwindcss/defaultTheme.js";

function withOpacityValue(variable) {
  return ({ opacityValue }) => {
    if (opacityValue === undefined) {
      return `hsl(var(${variable}))`;
    }
    return `hsl(var(${variable}) / ${opacityValue})`;
  };
}

/** @type {import('tailwindcss').Config} */
export default {
  darkMode: "class",
  content: ["./templates/**/*.{html,js,ts,jsx,tsx,eta}", "./index.eta"],
  theme: {
    colors: {
      textColor: withOpacityValue("--theme-text"),
      bgColor: withOpacityValue("--theme-background"),
      primary: withOpacityValue("--theme-primary"),
      secondary: withOpacityValue("--theme-secondary"),
      accent: withOpacityValue("--theme-accent"),
    },
    extend: {
      fontFamily: {
        sans: ["Iosevka Aile Resumos", ...defaultTheme.fontFamily.sans],
        mono: ["Iosevka Curly Resumos", ...defaultTheme.fontFamily.mono],
      },
      typography: ({ theme }) => ({
        DEFAULT: {
          css: {
            "--tw-prose-body": theme("colors.textColor"),
            "--tw-prose-headings": theme("colors.accent"),
            "--tw-prose-lead": theme("colors.primary"),
            "--tw-prose-links": theme("colors.accent"),
            "--tw-prose-bold": theme("colors.textColor"),
            "--tw-prose-counters": theme("colors.primary"),
            "--tw-prose-bullets": theme("colors.primary"),
            "--tw-prose-hr": theme("colors.primary"),
            "--tw-prose-quotes": theme("colors.primary"),
            "--tw-prose-quote-borders": theme("colors.primary"),
            "--tw-prose-captions": theme("colors.secondary"),
            "--tw-prose-code": theme("colors.textColor"),
            "--tw-prose-pre-code": theme("colors.textColor"),
            "--tw-prose-pre-bg": theme("colors.secondary"),
            "--tw-prose-th-borders": theme("colors.primary"),
            "--tw-prose-td-borders": theme("colors.primary"),

            pre: { fontSize: "1rem" },
            code: {
              fontSize: "1rem",
              padding: "0.25rem",
              borderRadius: "0.25rem",
              backgroundColor: theme("colors.secondary"),
            },
            "code::before": { content: "none" },
            "code::after": { content: "none" },

            "h2 code": { fontSize: "1.5rem" },
            "h3 code": { fontSize: "1.25rem" },

            h5: {
              color: theme("colors.accent"),
            },

            ".wrapped-table": {
              width: "100%",
              "overflow-x": "auto",
            },
            table: {
              width: "fit-content",
              "margin-left": "auto",
              "margin-right": "auto",
            },
            "blockquote p:first-of-type::before": { content: "none" },
            "blockquote p:first-of-type::after": { content: "none" },
            "td > p": { margin: "0 !important" },
            "li > p": { margin: "0 !important" },
          },
        },
        lg: {
          css: {
            pre: { fontSize: "1rem" },
            code: { fontSize: "1rem" },
            "h2 code": { fontSize: "1.666rem" },
            "h3 code": { fontSize: "1.333rem" },
          },
        },
      }),
    },
  },
  plugins: [require("@tailwindcss/typography")],
};
