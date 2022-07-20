Received: from mail-108-mta205.mxroute.com (mail-108-mta205.mxroute.com [136.175.108.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABFB7B
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 02:18:09 +0000 (UTC)
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta205.mxroute.com (ZoneMTA) with ESMTPSA id 18219613ff80000261.001
 for <iwd@lists.linux.dev>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Wed, 20 Jul 2022 02:13:00 +0000
X-Zone-Loop: a29631f8b5bf667a77617c12e3b476f657594a22a9c2
X-Originating-IP: [140.82.40.27]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=twosheds.org; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date
	:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=geTciZvFXcXfyEUyJvrYtYaEw1KhiHUNm4YfBPi6zr8=; b=BRQtKnYaerfttgVHyOpYYrhJbz
	/lkRiE+RMw5RTkafBTdjET6Sv9KnZoZFuIEbSvHvNaGeczPNytWHgBFYXTWkY2yNyQ4L0AsZVGb/R
	l8sf4M79P9K/SFNZPblQbwSbPYb1e6TUIMmRUdt857fmzTwfwlpEo1fBFfR+ORu9k/7t5JF92vBVa
	6wm8BEdMEbwtmdq/4STilAFfK6AQw18QH3CNlRJKF5Wp5oKo4iwRhmQA2rxokk0q6fOu2dkIx5aQe
	4SYnAZcrIaypwCapOfn999176497oUixnV8Una1/Oz+VzXw96gAGev51xVEyMSBDL8WE9u7rrdQXX
	TvgntNYw==;
From: Jesse Lentz <jesse@twosheds.org>
To: iwd@lists.linux.dev
Cc: Jesse Lentz <jesse@twosheds.org>
Subject: [PATCH] doc: Add "wep" to network type list
Date: Tue, 19 Jul 2022 22:12:26 -0400
Message-Id: <20220720021226.242780-1-jesse@twosheds.org>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: jesse@twosheds.org

Document "wep" as a possible network type.
---
 doc/network-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index 77536e28..2032faad 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -42,7 +42,7 @@ Properties	string Name [readonly]
 		string Type [readonly]
 
 			Contains the type of the network.  Possible
-			types are "open", "psk", "8021x" (EAP)
+			types are "open", "wep", "psk", or "8021x" (EAP)
 
 		object KnownNetwork [readonly, optional]
 
-- 
2.36.1

