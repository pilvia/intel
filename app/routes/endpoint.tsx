import { ActionFunction, json } from "@remix-run/cloudflare";

export const action: ActionFunction = async ({ request, context }) => {
  const data:any = await request.json();
  
  // SAVE to KV

  if (request.method == "POST") {
    const db:KVNamespace = context.intelStorage
    db.put(data.id, JSON.stringify(data))
    return json({status: 'ok, thanks!'});
  } else {
    throw new Error('Wrong method');
  }
  
};

