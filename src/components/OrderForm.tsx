'use client';

import { useState } from 'react';

export default function OrderForm({ itemTitle }: { itemTitle: string }) {
  const [name, setName] = useState('');
  const [address, setAddress] = useState('');

  return (
    <form className="flex flex-col gap-4 p-4 bg-white rounded-xl shadow-md h-full justify-center">
      <h2 className="text-xl font-semibold text-center">Order: {itemTitle}</h2>
      <input
        type="text"
        placeholder="Your name"
        className="border px-3 py-2 rounded-md"
        value={name}
        onChange={(e) => setName(e.target.value)}
      />
      <textarea
        placeholder="Shipping address"
        className="border px-3 py-2 rounded-md"
        value={address}
        onChange={(e) => setAddress(e.target.value)}
      />
      <button
        type="submit"
        className="bg-orange-500 text-white py-2 rounded-md hover:bg-orange-600"
      >
        Place Order
      </button>
    </form>
  );
}
