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

create LWC
