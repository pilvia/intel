import { ActionFunction, json } from "@remix-run/cloudflare";
import { kv } from "~/kv";

export const action: ActionFunction = async ({ request, context }) => {
  const data:any = await request.json();
  const db = kv(context)
  // SAVE to KV

  if (request.method == "POST") {
    db.put(data.id, JSON.stringify(data))
    return json({status: 'ok, thanks!'});
  } else {
    throw new Error('Wrong method');
  }
  
};

