import { json } from "@remix-run/cloudflare";

export async function loader({ }) {
    let apiUrl = "https://raw.githubusercontent.com/SMAPPNYU/ProgrammerGroup/master/LargeDataSets/sample-tweet.raw.json";
    let res = await fetch(apiUrl);
  
    let data = await res.json();
  

    return json(data);
  }