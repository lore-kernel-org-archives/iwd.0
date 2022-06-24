Received: from mail-108-mta83.mxroute.com (mail-108-mta83.mxroute.com [136.175.108.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B917C
	for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 16:51:05 +0000 (UTC)
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta83.mxroute.com (ZoneMTA) with ESMTPSA id 181969b17b100028a7.001
 for <iwd@lists.linux.dev>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Fri, 24 Jun 2022 16:45:55 +0000
X-Zone-Loop: 8fc2ea32b0abdb5da9712ec949ee51da367f1e2531ea
X-Originating-IP: [140.82.40.27]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=twosheds.org; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R2g66g3vRNOPNKgJgUHX/pXeMjem8m1ercLtbmrG/pI=; b=HSzPwjcpJOAsRBWQ7xNiBvE76k
	QfYbF8MFhT9IW+2U8jd2Tz+fh/Ac1ank058kX1EMg38hikkFh+DxwAYl5SUUqXDkWpgqCxE+I3+jO
	gv0CHXEwRDkhqpslumpusILmzTzWR3EzvjSGDjLRyhRZZysCenn1kokEOHy1UAn3MdNeg1ccW0P/h
	LcJlPHdvwf/cEwFe0GkvZmPFvL+wvYuzNmrzH9QprCupn28itnW/g6G9JqIZCwn34zs9yUSk69MF8
	e2HDPva8t85NU2Gtbc4ogMQRc4NAtNscVKN5+9DRlH9D5O9TWHSQVDe/hLO45esBQglw/F5QvyLYN
	/nJ2fvxw==;
From: Jesse Lentz <jesse@twosheds.org>
To: iwd@lists.linux.dev
Cc: Jesse Lentz <jesse@twosheds.org>
Subject: [PATCH 2/2] doc: Add new DeviceProvisioning API properties
Date: Fri, 24 Jun 2022 12:43:49 -0400
Message-Id: <20220624164346.254771-2-jesse@twosheds.org>
In-Reply-To: <20220624164346.254771-1-jesse@twosheds.org>
References: <20220624164346.254771-1-jesse@twosheds.org>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: jesse@twosheds.org

Document the Started, Role, and URI properties of the DeviceProvisioning
API.
---
 doc/device-provisioning-api.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/doc/device-provisioning-api.txt b/doc/device-provisioning-api.txt
index 0aba2557..ac204f46 100644
--- a/doc/device-provisioning-api.txt
+++ b/doc/device-provisioning-api.txt
@@ -56,3 +56,18 @@ Methods		string StartEnrollee()
 						net.connman.iwd.NotConfigured
 						net.connman.iwd.NotSupported
 						net.connman.iwd.Busy
+
+Properties	boolean Started [readonly]
+
+			True if DPP is currently active.
+
+		string Role [readonly, optional]
+
+			Indicates the DPP role. Possible values are "enrollee"
+			or "configurator". This property is only available when
+			Started is true.
+
+		string URI [readonly, optional]
+
+			Indicates the DPP URI. This property is only available
+			when Started is true.
-- 
2.36.1

