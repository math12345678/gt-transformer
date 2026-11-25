import React from 'react';

interface BrandLogoProps {
  compact?: boolean;
}

/**
 * Custom monoline inline SVG emblem:
 * Bold geometric "GT" letterforms woven into a horizontal DNA double-helix
 * crossover with negative-space strand breaks, paired with the "GROUND TRUTH" wordmark.
 */
export const BrandLogo: React.FC<BrandLogoProps> = ({ compact = false }) => {
  return (
    <span className="inline-flex items-center gap-3 whitespace-nowrap shrink-0 select-none">
      <svg
        width="48"
        height="24"
        viewBox="0 0 72 36"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
        aria-hidden="true"
        className="shrink-0"
      >
        {/* Complementary ascending recombination strand (split cleanly around the crossover) */}
        <path
          d="M 6 29.5 H 20.5 C 25.8 29.5 29.2 26.2 32.3 22.4"
          className="stroke-[#1B9E77] dark:stroke-[#2DD4A4]"
          strokeWidth="3.2"
          strokeLinecap="round"
          strokeLinejoin="round"
        />
        <path
          d="M 39.7 13.6 C 42.8 9.8 46.2 6.5 51.5 6.5 H 66"
          className="stroke-[#1B9E77] dark:stroke-[#2DD4A4]"
          strokeWidth="3.2"
          strokeLinecap="round"
          strokeLinejoin="round"
        />
        {/* Monoline "T" anchored inside the right helix loop */}
        <path
          d="M 50.5 11.8 H 66 M 58.2 11.8 V 24.8"
          className="stroke-[#1B9E77] dark:stroke-[#2DD4A4]"
          strokeWidth="3.2"
          strokeLinecap="round"
          strokeLinejoin="round"
        />

        {/* Primary descending strand crossing over the center */}
        <path
          d="M 6 6.5 H 20.5 C 27.5 6.5 31.5 12.2 36 18 C 40.5 23.8 44.5 29.5 51.5 29.5 H 66"
          className="stroke-[#141416] dark:stroke-[#F3F4F6]"
          strokeWidth="3.2"
          strokeLinecap="round"
          strokeLinejoin="round"
        />
        {/* Monoline "G" nested inside the left helix loop */}
        <path
          d="M 19.6 13.5 A 6.8 6.8 0 1 0 21.3 18 H 15.2"
          className="stroke-[#141416] dark:stroke-[#F3F4F6]"
          strokeWidth="3.2"
          strokeLinecap="round"
          strokeLinejoin="round"
        />
      </svg>

      {!compact && (
        <span className="text-[13.5px] font-semibold tracking-[0.14em] text-[#141416] dark:text-[#F3F4F6] uppercase">
          GROUND TRUTH
        </span>
      )}
    </span>
  );
};
