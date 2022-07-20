Received: from mail-108-mta105.mxroute.com (mail-108-mta105.mxroute.com [136.175.108.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0486015
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 16:16:46 +0000 (UTC)
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta105.mxroute.com (ZoneMTA) with ESMTPSA id 1821c60ef5c0000261.001
 for <iwd@lists.linux.dev>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Wed, 20 Jul 2022 16:11:31 +0000
X-Zone-Loop: f5aaf196f2b5192f72ef2805271fc83a0f83eeb69c1f
X-Originating-IP: [140.82.40.27]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=twosheds.org; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date
	:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ia8cGNRVXPh+f4/pcHEKQp2Nv8Q52DvYJhXa25QZY8g=; b=DExgJjEdSkfjUGJRyBIIpQ+zX/
	2pZB2M9UoVvDQGiHb8bkFQshhuylxEFxA7LKlJP6cuSnJ3V9O4zLpSzYTK9YlsSHCPo9ck30AWP73
	WqWrWc3a53EP54qm0JaFCi2ME1wqEqqCCAUDLbO6gYqJfJ5xusYD/Jde+R/B6rmIeT2a0oed0I8om
	vJjzBEN3rPD4bobVFHh4NL0gU/S34ES/7wfMPAcXBxZk/vqUd8REXIaBJqSejPf8IlKu4cnzTfWYo
	QBv+U82zQARDfQo/LL2GJFbu2qrDg0/a9f4IvChU9SpLqwLdYw4kQJslF9GO23xJKir9U9dFDQBnU
	ZPqMHniA==;
From: Jesse Lentz <jesse@twosheds.org>
To: iwd@lists.linux.dev
Cc: Jesse Lentz <jesse@twosheds.org>
Subject: [PATCH v2] doc: Mention "wep" network type
Date: Wed, 20 Jul 2022 12:11:08 -0400
Message-Id: <20220720161108.250369-1-jesse@twosheds.org>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: jesse@twosheds.org

Document "wep" as a possible Network Type. Mention that connections to WEP
networks are unsupported.
---
 doc/network-api.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index 77536e28..e4a34411 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -7,9 +7,9 @@ Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}/Xxx
 
 Methods		void Connect()
 
-			Connect to the network.  Request the device
-			implied by the object path to connect to specified
-			network.
+			Connect to the network.  Request the device implied by
+			the object path to connect to specified network.
+			Connecting to WEP networks is not supported.
 
 			Possible errors: net.connman.iwd.Aborted
 					 net.connman.iwd.Busy
@@ -42,7 +42,7 @@ Properties	string Name [readonly]
 		string Type [readonly]
 
 			Contains the type of the network.  Possible
-			types are "open", "psk", "8021x" (EAP)
+			types are "open", "wep", "psk", or "8021x" (EAP)
 
 		object KnownNetwork [readonly, optional]
 
-- 
2.36.1

