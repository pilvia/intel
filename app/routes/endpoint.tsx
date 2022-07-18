import { ActionFunction, json } from "@remix-run/cloudflare";



export const action: ActionFunction = async ({ request }) => {
  const data = await request.json();
  // KV save here
  if (request.method == "POST") {
    console.log(data)
    return json({status: 'ok'});
  } else {
    throw new Error('Wrong method');
  }
  
};

export async function loader({ }) {
    let apiUrl = "https://raw.githubusercontent.com/SMAPPNYU/ProgrammerGroup/master/LargeDataSets/sample-tweet.raw.json";
    let res = await fetch(apiUrl);
  
    let data = await res.json();
  

    return json(data);
  }