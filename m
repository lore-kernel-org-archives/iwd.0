Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92F413F428
	for <iwd@lists.linux.dev>; Wed,  7 Aug 2024 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054480; cv=none; b=MfCLH6eRv5Guju8SZ94udQal0imNU8ehbzJGxw7WmA0na3j/lD87i+qPuZE11mF1WC0Gvg6J2sy/iKcseT0VBwLRX6mrTTAUF7T+DzW6anTD222sjY68gsOOz0yLBhWMFQWnfA9z7PC2y/OR5ckH9JnHGbRVmmF23A53EKTqNFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054480; c=relaxed/simple;
	bh=N5ktHp55FAxev4Fe93AiflrA9E2h1tg4Y823bSvYpR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K0Sr+xMf6+U6DpiCFXnHWaWNzRaX2DdDnbcvU2N1fAhI+3wK5FSQKKps1TxGu9lpN7NqtOh3a3iLejnOzH7JpXpWcPq6LjxQo/VluqYBjqGM4MBgBQLyUgzA66lEpetGDpsO6w9Y9Mx8QJwG/1ZpTKrecpMC72R8V7dg95o109I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUJDkpjd; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUJDkpjd"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-260f863109cso118587fac.1
        for <iwd@lists.linux.dev>; Wed, 07 Aug 2024 11:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723054478; x=1723659278; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCM7mUQWtupCxt63H0cxJM+Qx+Ka5rFi9XYM48vSNfw=;
        b=TUJDkpjd0LsPC0hEAIDtfv27mH1ySpzR2Nz/HRxzP/d/Pe5OBaMv/TD75rH8Uklq5o
         1iFmLprPVwmlOetJFHPa9Dld9UayTD1yrditc13MacftkcCz15+r0QVQvHmxrgL8utB8
         XoiaR8rzX/YHFHHArXljylcmvArIDa8h3JdK887zmwfzMXuCgTlaDPFqYcMU1U+QVSJX
         Xhbxb6Jg75HPLT+tpO6fPNGl8zZ0nzZEh94cX54ozXZ7nZaoAh4sUsehqylRrF94NGB8
         z/y/pQF9vpRYJcD+NgRI4CZtxvkFBFb34adNvOY2AmaG8Vs4z3UNpPUSuEm/bDL+3woe
         Fzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054478; x=1723659278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCM7mUQWtupCxt63H0cxJM+Qx+Ka5rFi9XYM48vSNfw=;
        b=a2PzGdqjGSBsJ83pfP4iom+W1iWLxB1Ow8/IkOfT2b4ci/J76dOkYbtJJiljd+l6X7
         TVnhj8tjxN9re5Mn71K78tGTbcPaMSll2H90LseyKBo4jka9IQJkiW6CdZVyBuOfaUol
         N7sbMHLNkG/i4KjTys6CYfwUnehvHJr0uZNpo0qTpjHvGeJ+AuVyNoBIKeURnTvX9Jmn
         d1GCF7TYySl0hHHuhPV7+h1VWN7haAm6kXNUjmx0E7aoON/YRI8iscGUXvrnEwCzN6m6
         UbXoXYDfTlEqd5FATg0wrtgp9oldDByMP6lureERylpoAbB9bsQs14IlvZ+gZRQWPYyc
         DGvg==
X-Gm-Message-State: AOJu0YyOo6KdYYxakT6AoHO1dPlJtJL3RP75sfIVadvB7cePUQsLfoKw
	XeggsoJLknkCKaZCRHaHefL/to3dk8k6xPN70jdNWsTdE3pkVkFm1adzxg==
X-Google-Smtp-Source: AGHT+IFQvl+co6/jODp+8J3LwVnKclw/wMnk8te5ZfIXF9WOatSkRW0NYx0ALL0AIbCqefFVHfEtRQ==
X-Received: by 2002:a05:6870:b28b:b0:261:26be:2606 with SMTP id 586e51a60fabf-26891d705d1mr21846369fac.25.1723054477652;
        Wed, 07 Aug 2024 11:14:37 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d0db4sm82194685a.7.2024.08.07.11.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:14:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/14] dbus: Add net.connman.iwd.BasicServiceSet interface
Date: Wed,  7 Aug 2024 11:14:17 -0700
Message-Id: <20240807181427.170515-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807181427.170515-1-prestwoj@gmail.com>
References: <20240807181427.170515-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/dbus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/dbus.h b/src/dbus.h
index b43412d7..14814b5d 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -48,6 +48,7 @@
 #define IWD_NETCONFIG_AGENT_INTERFACE \
 	"net.connman.iwd.NetworkConfigurationAgent"
 #define IWD_SHARED_CODE_AGENT_INTERFACE "net.connman.iwd.SharedCodeAgent"
+#define IWD_BSS_INTERFACE "net.connman.iwd.BasicServiceSet"
 
 #define IWD_BASE_PATH "/net/connman/iwd"
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
-- 
2.34.1

