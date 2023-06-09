import React from 'react';
import { createRoot } from 'react-dom/client';
import App from "./components/App";
import { AuthClient } from '@dfinity/auth-client';



const root = createRoot(document.getElementById("root")); // createRoot(container!) if you use TypeScript
root.render(<App/>);



// const init = async()=>{
//     const authClient = await AuthClient.create();
//     if(await authClient.isAuthenticated()){
//         handleAuthenticated(authClient);
//     }else{
//         await authClient.login({
//             identityProvider:"https://identity.ic0.app/#authorize",
//             onSuccess:()=>{
//                 handleAuthenticated(authClient);
//             }
//         })
//     }
    
// }

// async function handleAuthenticated(authClient){
//     const identity = await authClient.getIdentity();
//     const userPrincipal = identity._principal.toString();
//     const root = createRoot(document.getElementById("root")); // createRoot(container!) if you use TypeScript
//     root.render(<App/>);
// }

// init();