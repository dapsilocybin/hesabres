'use client';

import { ReactNode, useState } from 'react';
import { cn } from '@/lib/utils'; // Utility for merging Tailwind classes (optional)

interface FlipCardProps {
  front: ReactNode;
  back: ReactNode;
}

export default function FlipCard({ front, back }: FlipCardProps) {
  const [flipped, setFlipped] = useState(false);

  return (
    <div className="w-full max-w-md mx-auto perspective">
      <div
        className={cn(
          'relative w-full h-[500px] transition-transform duration-500 transform-style-preserve-3d',
          flipped ? 'rotate-y-180' : ''
        )}
      >
        <div className="absolute w-full h-full backface-hidden">
          {front}
          <button
            onClick={() => setFlipped(true)}
            className="mt-4 px-4 py-2 bg-orange-500 text-white rounded-full"
          >
            Next
          </button>
        </div>
        <div className="absolute w-full h-full rotate-y-180 backface-hidden">
          {back}
          <button
            onClick={() => setFlipped(false)}
            className="mt-4 px-4 py-2 bg-gray-300 rounded-full"
          >
            Back
          </button>
        </div>
      </div>
    </div>
  );
}
