// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    // トークンの基本情報
    string public name = "Sushi Tech Token";
    string public symbol = "STT";
    uint256 public totalSupply = 1000000;

    // 誰が何枚持っているかを記録する台帳（DeFiの心臓部）
    mapping(address => uint256) public balanceOf;

    // お金が動いたことを記録するイベント
    event Transfer(address indexed from, address indexed to, uint256 value);

    // 最初に一度だけ動く処理（発行者が全額もらう）
    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    // 送金機能（これがDeFiの基本！）
    function transfer(address _to, uint256 _value) public returns (bool success) {
        // 送る人が十分なお金を持っているかチェック
        require(balanceOf[msg.sender] >= _value, "Not enough tokens");

        // 送る人の残高を減らす
        balanceOf[msg.sender] -= _value;
        // 受け取る人の残高を増やす
        balanceOf[_to] += _value;

        // 記録を残す
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
}
