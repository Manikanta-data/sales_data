CREATE DATABASE  IF NOT EXISTS `ecommerce` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ecommerce`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `customerlifetimevalue`
--

DROP TABLE IF EXISTS `customerlifetimevalue`;
/*!50001 DROP VIEW IF EXISTS `customerlifetimevalue`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `customerlifetimevalue` AS SELECT 
 1 AS `customer_id`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `email`,
 1 AS `order_count`,
 1 AS `total_spent`,
 1 AS `avg_order_value`,
 1 AS `days_as_customer`,
 1 AS `monthly_value`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `shippingperformance`
--

DROP TABLE IF EXISTS `shippingperformance`;
/*!50001 DROP VIEW IF EXISTS `shippingperformance`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `shippingperformance` AS SELECT 
 1 AS `carrier`,
 1 AS `total_shipments`,
 1 AS `delivered_count`,
 1 AS `on_time_count`,
 1 AS `avg_delivery_days`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `customerlifetimevalue`
--

/*!50001 DROP VIEW IF EXISTS `customerlifetimevalue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customerlifetimevalue` AS select `c`.`customer_id` AS `customer_id`,`c`.`first_name` AS `first_name`,`c`.`last_name` AS `last_name`,`c`.`email` AS `email`,count(`o`.`order_id`) AS `order_count`,sum(`o`.`total_amount`) AS `total_spent`,(sum(`o`.`total_amount`) / nullif(count(`o`.`order_id`),0)) AS `avg_order_value`,(to_days(curdate()) - to_days(min(`o`.`order_date`))) AS `days_as_customer`,((sum(`o`.`total_amount`) / nullif((to_days(curdate()) - to_days(min(`o`.`order_date`))),0)) * 30) AS `monthly_value` from (`customers` `c` left join `orders` `o` on((`c`.`customer_id` = `o`.`customer_id`))) group by `c`.`customer_id`,`c`.`first_name`,`c`.`last_name`,`c`.`email` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `shippingperformance`
--

/*!50001 DROP VIEW IF EXISTS `shippingperformance`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `shippingperformance` AS select `shipping`.`carrier` AS `carrier`,count(0) AS `total_shipments`,sum((case when (`shipping`.`status` = 'Delivered') then 1 else 0 end)) AS `delivered_count`,sum((case when ((to_days(`shipping`.`delivery_date`) - to_days(`shipping`.`shipping_date`)) <= (to_days(`shipping`.`estimated_delivery`) - to_days(`shipping`.`shipping_date`))) then 1 else 0 end)) AS `on_time_count`,avg((to_days(`shipping`.`delivery_date`) - to_days(`shipping`.`shipping_date`))) AS `avg_delivery_days` from `shipping` where (`shipping`.`status` = 'Delivered') group by `shipping`.`carrier` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'ecommerce'
--

--
-- Dumping routines for database 'ecommerce'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-10 15:33:34
