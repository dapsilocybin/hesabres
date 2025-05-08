"use client";

import { mockItems } from "@/app/mockData";
import { useParams, useRouter } from "next/navigation";
import { useState } from "react";

export default function OrderPage() {
  const { id } = useParams();
  const router = useRouter();
  const item = mockItems[id as string];

  const [form, setForm] = useState({
    name: "",
    phone: "",
    address: "",
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = () => {
    console.log("Mock Order Submitted:", { item, form });
    router.push(`/receipt/${id}`); // Simulated redirect
  };

  if (!item) return <div className="p-4">Item not found</div>;

  return (
    <div className="p-4 max-w-xl mx-auto space-y-6">
      <img
        src={item.image}
        alt={item.title}
        className="w-full h-64 object-cover rounded-2xl shadow"
      />
      <h1 className="text-2xl font-semibold">{item.title}</h1>
      <p className="text-gray-600">{item.description}</p>
      <p className="text-xl font-bold text-orange-600">${item.price}</p>

      <div className="space-y-4 pt-4">
        <input
          type="text"
          name="name"
          placeholder="Your name"
          value={form.name}
          onChange={handleChange}
          className="w-full p-3 border rounded-xl"
        />
        <input
          type="text"
          name="phone"
          placeholder="Phone number"
          value={form.phone}
          onChange={handleChange}
          className="w-full p-3 border rounded-xl"
        />
        <input
          type="text"
          name="address"
          placeholder="Delivery address"
          value={form.address}
          onChange={handleChange}
          className="w-full p-3 border rounded-xl"
        />
        <button
          onClick={handleSubmit}
          className="w-full bg-orange-500 text-white p-3 rounded-2xl font-semibold hover:bg-orange-600 transition"
        >
          Place Order
        </button>
      </div>
    </div>
  );
}
