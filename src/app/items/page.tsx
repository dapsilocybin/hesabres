// app/items/page.tsx
import ItemCard from "@/components/ItemCard";
import { mockItems } from "../mockData";


export default function ItemsPage() {
  return (
    <div className="p-4 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
      {mockItems.map((item: Record<string, any>) => (
        <ItemCard key={item.id} item={item} />
      ))}
    </div>
  );
}
