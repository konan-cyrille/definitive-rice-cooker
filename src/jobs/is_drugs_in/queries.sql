-- REQUETE 1
WITH
tmp_transactions_data as (
    SELECT '01/01/2019' date, 1234 order_id, 999 client_id, 490756 prod_id, 50 prod_price, 1 prod_qty
    UNION ALL
    SELECT '01/01/2020', 1234, 999, 389728, 3.56, 4
    UNION ALL
    SELECT '01/03/2019', 3456, 845, 490756, 50, 2
),
tmp0 as (
    SELECT date, 
        prod_price, 
        prod_qty,
    FROM tmp_transactions_data
    WHERE date BETWEEN '01/01/2019' AND '31/12/2019'
)
SELECT date,
    sum(prod_price * prod_qty) as ventes
FROM tmp0
GROUP BY date;


-- REQUETE 2
WITH
tmp_transactions_data as (
    SELECT '01/01/2019' date, 1234 order_id, 999 client_id, '490756' prod_id, 50 prod_price, 1 prod_qty
    UNION ALL
    SELECT '01/01/2020', 1234, 999, '389728', 3.56, 4
    UNION ALL
    SELECT '01/03/2019', 3456, 845, '490756', 50, 2
),
tmp_product_nomenclature_data as (
    SELECT '490756' product_id, 'MEUBLE' product_type, 'Chaise' product_name
    UNION ALL
    SELECT '389728', 'DECO', 'Boule de Noël'
    UNION ALL
    SELECT '549380', 'MEUBLE', 'Canapé'
    UNION ALL
    SELECT '293718', 'DECO', 'Mug'
),
tmp0 as (
    SELECT date,
        client_id,
        prod_id,
        prod_price * prod_qty ventes_per_prod
    FROM tmp_transactions_data
    WHERE date BETWEEN '01/01/2019' AND '31/12/2019'
),
tmp_joined as (
SELECT tmp0.date,
    tmp0.client_id,
    tmp0.prod_id,
    tmp0.ventes_per_prod,
    tmp_pnd.product_type
FROM tmp0
LEFT JOIN tmp_product_nomenclature_data tmp_pnd
ON tmp0.prod_id = tmp_pnd.product_id
),
tmp_ventes_meubles as(
  SELECT client_id,
    ventes_per_prod as ventes_meubles
  FROM tmp_joined
  WHERE product_type = 'MEUBLE'
),
tmp_ventes_deco as(
  SELECT client_id,
    ventes_per_prod as ventes_deco
  FROM tmp_joined
  WHERE product_type = 'DECO'
),
tmp_ventes_meubles_and_deco as(
  SELECT td.client_id,
    vm.ventes_meubles,
    null ventes_deco
  FROM tmp_ventes_meubles vm
  LEFT JOIN tmp_transactions_data td
  ON td.client_id = vm.client_id
  UNION DISTINCT
  SELECT td.client_id,
    null ventes_meubles,
    vd.ventes_deco
  FROM tmp_ventes_deco vd
  LEFT JOIN tmp_transactions_data td
  ON td.client_id = vd.client_id
)
SELECT client_id,
  sum(ventes_meubles) ventes_meubles,
  sum(ventes_deco) ventes_deco
FROM tmp_ventes_meubles_and_deco
GROUP BY client_id


