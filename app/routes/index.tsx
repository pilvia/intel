import { json, LoaderFunction } from "@remix-run/cloudflare"; 
import { useLoaderData } from "@remix-run/react";
import { kv } from "~/kv";


export const loader: LoaderFunction = async({ context }) => {
  const db = kv(context)
 
  let data = await db.list();
  const list = []
  
  for (let key of data.keys) {
    const data = await db.get(key.name)
    if (data) {
      const jsonData = JSON.parse(data);
      list.push({
        id: key.name,
        data: jsonData
      }
      );
    }
    
  }
  console.log(list);
  return json(list);
}

export default function Index() {
  
  const hosts = useLoaderData()
  return (
    <>
    <h1>Pilvia Intel</h1>
    <ul>
    {hosts.map((host:any) => (
        <li key={host.id}>{host.id} DATA: {JSON.stringify(host.data)}</li>
      ))}
    </ul>
    </>
  );
}
