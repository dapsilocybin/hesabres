'use client';

import Image from 'next/image';
import { FC } from 'react';


interface ItemCardProps {
  item: Record<string, any>;
  onOrderClick?: (item: Record<string, any>) => void;
}

const ItemCard: FC<ItemCardProps> = ({ item, onOrderClick }) => {
  return (
    <div className="rounded-2xl border p-4 shadow-sm hover:shadow-md transition duration-200 bg-white">
      <div className="relative w-full h-48 mb-3 overflow-hidden rounded-xl">
        <Image
          src={item.image}
          alt={item.title}
          fill
          className="object-cover"
        />
      </div>
      <h3 className="text-lg font-semibold mb-1">{item.title}</h3>
      <p className="text-sm text-gray-600 line-clamp-2 mb-2">{item.description}</p>
      <div className="flex justify-between items-center">
        <span className="font-bold text-orange-600">${item.price}</span>
        <button
          onClick={() => onOrderClick?.(item)}
          className="bg-orange-500 text-white text-sm px-4 py-1 rounded-full hover:bg-orange-600"
        >
          Order
        </button>
      </div>
    </div>
  );
};

export default ItemCard;
