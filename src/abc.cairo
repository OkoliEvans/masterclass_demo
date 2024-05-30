use starknet::ContractAddress;

#[starknet::interface]
pub trait IERC20<T> {
    fn transfer(ref self: T, to: ContractAddress, amount: u256);
    fn transfer_from(ref self: T, from: ContractAddress, to: ContractAddress, amount: u256);
}

// #[starknet::contract]
// mod ERC20 {
//     use super:: { IERC20Dispatcher, IERC20, IERC20LibraryDispatcher};
//     use starknet::ContractAddress;

//     #[storage]
//     struct Storage {
//         amount: u256,
//         balance: u256,
//         allowance: u256
//     }

//     #[abi(embed_v0)]
//     impl IERC20Trait of IERC20<ContractState> {
//         fn transfer(ref self: ContractState, to: ContractAddress, amount: u256) {

//         }

//         fn transfer_from(ref self: ContractState, from: ContractAddress, to: ContractAddress, amount: u256) {
            
//         }
//     }


// }
