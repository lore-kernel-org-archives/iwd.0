Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D381862B8
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477594; cv=none; b=ItvwlpAFYntqtWymqjZMawsBnbk1wDGCcgrsA33mSI6RBMSTg+KoKhSCkF2LUesr4dGdIwCQDtj2TMH18wxJJuSFZpDEQMZY0VJRkJq4z5BzNwdHMrU+/TxKhVJ4iTgBf/NNf8hu95R97B/+JTG5BHjt/lF+4Efb6BHpNLjt+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477594; c=relaxed/simple;
	bh=L4W3PB+g4jBEte+Do1+h9fxmKOADzWcA8/fRrBNtNx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V5gSPdJFkAjhr5CWyK88Oslmd5fTUzLes7iOWFCNOU6iBEjpQm3ggZ5vdhmsyWbz+bJWtKpeO5REok4Y8yBR3z0tHw2XubQh9tNwTjjlU7U6agWGOMYWR6Kh9IIOQtwfSFRgjUCXLw+7/uAra9RPPW1IK58gg+C+fRfQJc3W1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQwSPNP5; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQwSPNP5"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5b3fff87e6bso5037806a12.0
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477591; x=1724082391; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMD1SmJ3yUMRnAU5EICc73uBS+J/IxStg9QYcmtUZIQ=;
        b=KQwSPNP5HYNDifuC60+jfHSbPzjeRTMPdOF6HRFJRJd3W23BP3VWvNjrmRK0k1cbpw
         L3drNBXKtnj5LMQSLh1G03IV/STKilq8rMcMZq1PUcka5eNqdjROf5Kb88WHVbWbhFK0
         BbCjLrXY9OL40ETfReKmmv4dXLQP5YCv+M7jc9gp/Gy055LtHadvUT/Qq3tqXDXDdQQc
         VkVhvzyQmWT/j8PQVzcfLoP/V/qJtRgZUhDBpUc1Ey7Y/Af1mWu9dMMxrdX7SLEqlWKD
         QDVYi/sxmkcCokJM45XtsfsssoycxmecYQmV14aEwWQQbcLDvciAAxzzezh+Vg+D1hHD
         NJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477591; x=1724082391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMD1SmJ3yUMRnAU5EICc73uBS+J/IxStg9QYcmtUZIQ=;
        b=ZJe+Idx1EDb/9WRkV7ai49yoceu42QGdmUlVaOzghvIh5XDx1cZf2BEYmFSZw080j9
         WuPoMwJOsETCb5TWbqioKyPA54UqnPTsFglZOSgxnMEjexCV86ltDXXLdSwRB3vh/UkL
         lZ+oB0p8KTT6n1rI+Qtvi8IgRFrhcERiLGnx2BVdb1w0O3qtJ3wydOD122e5JaAxn3GW
         jHEBRmQfIWgXlh4oDmh8/j5Bsfafln0FfDXz/gp0dkDzVwA/OlYbgHlRh7l2YoGY018n
         4xkYYRl0InoGPi2383DbfirHjmxKJeCbgohYKPPIWO+zOiTLA1shyzJ2k1usfnKYqJer
         DpKA==
X-Gm-Message-State: AOJu0YwngStLkElT6w39GIMAK0eZvn6YF49lXDeSZQCECdhjvzNoeOe9
	fAwab/6tWQ5gKnuP7BsmtF8IF6fl5BBKHJIu1nzyVIUFsoXDb97IiTe4BA==
X-Google-Smtp-Source: AGHT+IHCpSu+GbLejFUVInp0St/YOm/L7L2zmlfuDHhjMBe81N+cOvXB/VLl2+NoCWEbnzGl14QRDA==
X-Received: by 2002:a05:6402:90b:b0:5b9:1009:f42d with SMTP id 4fb4d7f45d1cf-5bd44c78caemr447963a12.32.1723477590876;
        Mon, 12 Aug 2024 08:46:30 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190adb45sm2224931a12.32.2024.08.12.08.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:46:30 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 07/13] doc: document BasicServiceSet API
Date: Mon, 12 Aug 2024 08:46:07 -0700
Message-Id: <20240812154613.126522-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812154613.126522-1-prestwoj@gmail.com>
References: <20240812154613.126522-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/basic-service-set.txt | 10 ++++++++++
 doc/network-api.txt       |  5 +++++
 doc/station-api.txt       |  6 ++++++
 3 files changed, 21 insertions(+)
 create mode 100644 doc/basic-service-set.txt

diff --git a/doc/basic-service-set.txt b/doc/basic-service-set.txt
new file mode 100644
index 00000000..f827ca02
--- /dev/null
+++ b/doc/basic-service-set.txt
@@ -0,0 +1,10 @@
+Basic service set hierarchy
+=================
+
+Service		net.connman.iwd
+Interface	net.connman.iwd.BasicServiceSet
+Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}/Xxx
+
+Properties	string Address [readonly]
+
+			MAC address of BSS
diff --git a/doc/network-api.txt b/doc/network-api.txt
index e4a34411..8bc6eea6 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -50,3 +50,8 @@ Properties	string Name [readonly]
 			corresponding to this Network.  If the network
 			is not provisioned or has not been connected to
 			before, the property is omitted.
+
+		array(object) ExtendedServiceSet [readonly]
+
+			Contains a list of paths of each individual
+			BasicServiceSet object.
diff --git a/doc/station-api.txt b/doc/station-api.txt
index 05dd137e..84f1b7bf 100644
--- a/doc/station-api.txt
+++ b/doc/station-api.txt
@@ -164,6 +164,12 @@ Properties	string State [readonly]
 			for networks.  net.connman.iwd.Network objects are
 			updated when this property goes from true to false.
 
+		object ConnectedAccessPoint [readonly, optional]
+
+			net.connman.iwd.BasicServiceSet object represeting the
+			BSS the device is currently connected to or to which
+			a connection is in progress.
+
 SignalLevelAgent hierarchy
 ==========================
 
-- 
2.34.1

