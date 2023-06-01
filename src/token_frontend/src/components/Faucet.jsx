import React from "react";
import {token_backend, canisterId,createActor } from "../../../declarations/token_backend";
import {AuthClient} from "@dfinity/auth-client";


function Faucet(props) {
  const [isDisabled, setDisabled] = React.useState(false);
  const [buttonText, setButtonText] = React.useState("Claim free token");
 
  async function handleClick(event) {
    setDisabled(true);
    const authClient = await AuthClient.create();
    const identity = await authClient.getIdentity();

    const authenticatedCanister = createActor(canisterId, {agentOptions:{identity,},});

    setButtonText(await authenticatedCanister.payOut());
  }

  return (
    <div className="blue window">
      <h2>
        <span role="img" aria-label="tap emoji">
          🚰
        </span>
        Faucet
      </h2>
      <label>Get your free ADKE tokens here! Claim 10,000 ADKE coins to <br></br>{props.userPrincipal}</label>
      <p className="trade-buttons">
        <button id="btn-payout" onClick={handleClick} disabled={isDisabled}>
          {buttonText}
        </button>
      </p>
    </div>
  );
}

export default Faucet;
