3. OAuth Authentication
Objective: Master OAuth authentication flows and work with secured APIs.

Challenge:

Connect Salesforce to the GitHub API.
Authenticate using OAuth 2.0 (set up Named Credentials for GitHub).
Fetch and display the list of repositories for a given GitHub account in a Salesforce LWC.
Bonus:

Implement a search bar in the LWC to search repositories by name or description.
Store repository details (e.g., name, stars, forks) in Salesforce for future reference.

create Github OAuth
create Named Credentials
create External Credentials
create Principal
create AuthProvider
create Permission Set
create Apex class
public with sharing class GitHubIntegration {
    @AuraEnabled(cacheable=true)
    public static List<Repository> getRepositories() {
        List<Repository> repoList = new List<Repository>();

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:GitHub_OAuth/user/repos');
        req.setMethod('GET');
        req.setHeader('Accept', 'application/json');

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            List<Object> jsonResponse = (List<Object>) JSON.deserializeUntyped(res.getBody());

            for (Object obj : jsonResponse) {
                Map<String, Object> repo = (Map<String, Object>) obj;
                repoList.add(new Repository(
                    (String) repo.get('name'),
                    (String) repo.get('html_url'),
                    (Integer) repo.get('stargazers_count'),
                    (Integer) repo.get('forks_count')
                ));
            }
        }
        return repoList;
    }

    public class Repository {
        @AuraEnabled public String name;
        @AuraEnabled public String url;
        @AuraEnabled public Integer stars;
        @AuraEnabled public Integer forks;

        public Repository(String name, String url, Integer stars, Integer forks) {
            this.name = name;
            this.url = url;
            this.stars = stars;
            this.forks = forks;
        }
    }
}

create LWC HTMl
<template>
    <lightning-card title="GitHub Repositories" icon-name="utility:knowledge_base">
        <div class="slds-m-around_medium">
            <lightning-input type="search" label="Search Repository" onchange={handleSearch}></lightning-input>
            <template if:true={repos}>
                <lightning-datatable key-field="id" data={filteredRepos} columns={columns}>
                </lightning-datatable>
            </template>
        </div>
    </lightning-card>
</template>

create LWC JS
import { LightningElement, wire, track } from 'lwc';
import getRepositories from '@salesforce/apex/GitHubIntegration.getRepositories'; // Correct import

export default class GithubRepos extends LightningElement {
    @track repos = [];
    @track filteredRepos = [];

    columns = [
        { label: 'Name', fieldName: 'url', type: 'url', typeAttributes: { label: { fieldName: 'name' } } },
        { label: 'Stars', fieldName: 'stars', type: 'number' },
        { label: 'Forks', fieldName: 'forks', type: 'number' }
    ];

    @wire(getRepositories)
    wiredRepos({ error, data }) {
        if (data) {
            this.repos = data;
            this.filteredRepos = data;
        } else if (error) {
            console.error('Error fetching repositories:', error);
        }
    }

    handleSearch(event) {
        const searchKey = event.target.value.toLowerCase();
        this.filteredRepos = this.repos.filter(repo =>
            repo.name.toLowerCase().includes(searchKey)
        );
    }
}


