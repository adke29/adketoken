import React,{useState} from "react";
import { token_backend } from "../../../declarations/token_backend";
import {Principal} from "@dfinity/principal";

function Transfer() {
  const [to, changeTo] = useState("");
  const [amount, changeAmount] = useState("");
  const [isDisabled, setDisabled]= useState(false);
  const [feedback, setFeedback] = useState("");
  const [isHidden, setHidden] = useState(true);

  async function handleClick() {
    setDisabled(true);
    setHidden(true);
    setFeedback(await token_backend.transfer(Principal.fromText(to),Number(amount)));
    setHidden(false);
    setDisabled(false);
    changeTo("");
    changeAmount("");
  }

  return (
    <div className="window white">
      <div className="transfer">
        <fieldset>
          <legend>To Account:</legend>
          <ul>
            <li>
              <input
                type="text"
                id="transfer-to-id"
                value = {to}
                onChange = {(e)=>{changeTo(e.target.value)}}
              />
            </li>
          </ul>
        </fieldset>
        <fieldset>
          <legend>Amount:</legend>
          <ul>
            <li>
              <input
                type="number"
                id="amount"
                value = {amount}
                onChange = {(e)=>{changeAmount(e.target.value)}}
              />
            </li>
          </ul>
        </fieldset>
        <p className="trade-buttons">
          <button id="btn-transfer" onClick={handleClick} disabled = {isDisabled}>
            Transfer
          </button>
        </p>
        <p hidden = {isHidden}>{feedback}</p>
      </div>
    </div>
  );
}

export default Transfer;
