# RWA DAO Project

 DAO project specifically designed for managing Resident Welfare Associations.

### How It Can Be Modified More - 

1. We can make it specific for any NFT holder by importing the ERC721 contract from Openzeppelin. 

2. We can use a token system to enter the DAO. Can use Chainlink Price Feed to fetch the price of any Token that will be used.


### Psuedocode I used:

```shell
// RWA contract
contract RWA {
    struct Proposal {
        string title;
        string description;
        uint votesInFavor;
        uint votesAgainst;
        bool isExecuted;
    }
    
    struct RWAData {
        string name;
        address[] members;
        Proposal[] proposals;
    }

    mapping(address => RWAData) private rwas;

    // Event emitted when a new RWA is created
    event RWAAdded();

    // Event emitted when a member is added to an RWA
    event MemberAdded();

    // Event emitted when a member is removed from an RWA
    event MemberRemoved();

    // Event emitted when a member votes on a proposal
    event Vote();

    // Event emitted when a new proposal is created
    event ProposalCreated();

    // Function to create a new RWA
    function createRWA() public {}

    // Function to add a member to an RWA
    function addMember() public {}

    // Function to remove a member from an RWA
    function removeMember() public {}

    // Function for a member to vote on a proposal
    function vote() public {}

    // Function to create a new proposal
    function createProposal() public {}

```

I used Hardhat and Alchemy for this Project, but since its a basic DAO contract I will just run it on remix.org 
Contract deployed address - 0xd9145CCE52D386f254917e481eB44e9943F39138

![Screenshot (183)](https://github.com/PavanTamrakar/RWADAO/assets/72463719/9d4fb98c-e20e-4db1-9e87-0f8dabc8928d)
