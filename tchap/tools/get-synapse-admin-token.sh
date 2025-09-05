#docker exec -it element-docker-demo-synapse-1 register_new_matrix_user -c /data/homeserver.yaml -a -u admin -p admin

#-> retourne 404

# creer le user dans le MAS à la main

# puis

#  docker exec -it element-docker-demo-postgres-1 psql -U matrix -d synapse

# SELECT name, admin FROM users WHERE name LIKE '%admin%';

# UPDATE users SET admin = 1 WHERE name = '@admin:tchapgouv.com';


# se connecter à tchap web et recuperer le jeton

# 
# 


# curl --header "Authorization: Bearer mat_k2Bl43Sv7qFj2rmp50wi0OtT96lQpr_9kQF44" -X GET http://127.0.0.1:8008/_synapse/admin/v2/users/@foo:bar.com
# ca marche pas à cause de https://github.com/element-hq/matrix-authentication-service/issues/2913


# ca fonctionne avec le token utilisé par le MAS pours e connecter aux API de synapse : 


#Dans votre configuration Synapse, j'ai vu cette ligne :

#```yaml
#admin_token: '/DjWc4D3yyqgjYN8tum65g'
#```


curl -X GET \
  -H "Authorization: Bearer /DjWc4D3yyqgjYN8tum65g" \
  "https://matrix.tchapgouv.com/_synapse/admin/v2/users/@admin:tchapgouv.com"


  curl -X GET \
  -H "Authorization: Bearer /DjWc4D3yyqgjYN8tum65g" \
  "https://matrix.tchapgouv.com/_synapse/admin/v2/users?from=0&limit=10&guests=false"




curl -X GET \
  -H "Authorization: Bearer /DjWc4D3yyqgjYN8tum65g" \
  "https://matrix.tchapgouv.com/_synapse/admin/v2/users/@playwright_test_user_1745312065733_114:tchapgouv.com"

```json
{"name":"@playwright_test_user_1745312065733_114:tchapgouv.com","admin":false,"deactivated":false,"locked":false,"shadow_banned":false,"creation_ts":1745312069,"appservice_id":null,"consent_server_notice_sent":null,"consent_version":null,"consent_ts":null,"user_type":null,"is_guest":false,"suspended":false,"displayname":"playwright_test_user_1745312065733_114 playwright_test_user_1745312065733_114","avatar_url":null,"threepids":[{"medium":"email","address":"playwright_test_user_1745312065733_114@tchapgouv.com","validated_at":1745312069639,"added_at":1745312069639}],"external_ids":[{"auth_provider":"oauth-delegated","external_id":"01JSEB9DRPSCPYXQXT0S6SN59T"}],"erased":false,"last_seen_ts":null}
```

curl -X PUT \
  -H "Authorization: Bearer /DjWc4D3yyqgjYN8tum65g" \
  -d '{"external_ids": []}' \
  -H "Content-Type: application/json" \
  "https://matrix.tchapgouv.com/_synapse/admin/v2/users/@playwright_test_user_1745312065733_114:tchapgouv.com"
