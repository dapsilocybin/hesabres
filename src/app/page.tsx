"use client";

import { useRouter } from "next/navigation";
import { mockItems } from "./mockData";

export default function HomePage() {
  const router = useRouter();

  return (
    <div className="p-6 max-w-4xl mx-auto space-y-6">
      <h1 className="text-3xl font-bold text-center text-orange-600">Shop Items</h1>
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        {Object.values(mockItems).map((item) => (
          <div
            key={item.id}
            className="bg-white shadow rounded-xl p-4 cursor-pointer hover:scale-105 transition-transform"
            onClick={() => router.push(`/order/${item.id}`)}
          >
            <img
              src={item.image}
              alt={item.title}
              className="w-full h-48 object-cover rounded-xl"
            />
            <h2 className="text-lg font-semibold mt-2">{item.title}</h2>
            <p className="text-sm text-gray-600">{item.description}</p>
            <p className="text-orange-600 font-bold mt-1">${item.price}</p>
          </div>
        ))}
      </div>
    </div>
  );
}
