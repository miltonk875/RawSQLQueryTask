/******************************************* Total Customer in Carts *******************************/
select 
	count(*) as in_cart
from 
	bbbd_ecommerce_test.carts  
WHERE 
	DATE(carts.created_at) BETWEEN '2025-04-12' AND '2025-04-12';
	
/******************************************* Total Customer in wishlists *******************************/

select 
	count(*) as in_wishlists
from 
	bbbd_ecommerce_test.wishlists  
WHERE 
	DATE(wishlists.created_at) BETWEEN '2025-04-12' AND '2025-04-12';