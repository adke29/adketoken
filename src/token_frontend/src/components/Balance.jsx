import React from "react";
import { token_backend } from "../../../declarations/token_backend";
import { Principal } from "@dfinity/principal";

function Balance() {
  const [inputValue, setInput] = React.useState("");
  const [balance, setBalance] = React.useState("");
  const [symbol, setSymbol] = React.useState("");
  const [isHidden, hide] = React.useState(true);
  const [isDisabled, setDisabled] = React.useState(false);

  async function handleClick() {
    const principal = Principal.fromText(inputValue);
    setDisabled(true);
    let result = await token_backend.balanceOf(principal);
    setBalance(result.toLocaleString());
    setSymbol(await token_backend.getSymbol());
    setDisabled(false);
    hide(false);
  }


  return (
    <div className="window white">
      <label>Check account token balance:</label>
      <p>
        <input
          id="balance-principal-id"
          type="text"
          placeholder="Enter a Principal ID"
          value={inputValue}
          onChange={(e) => { setInput(e.target.value) }}
        />
      </p>
      <p className="trade-buttons">
        <button
          id="btn-request-balance"
          onClick={handleClick}
          disabled={isDisabled}
        >
          {isDisabled ? "Checking...." : "Check Balance"}
        </button>
      </p>
      <p hidden={isHidden}>This account has a balance of {balance} {symbol}</p>
    </div>
  );
}

export default Balance;
