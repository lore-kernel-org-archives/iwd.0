Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC74191460
	for <iwd@lists.linux.dev>; Thu,  8 Aug 2024 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138968; cv=none; b=BUJBSNFyGvv769amtlWT+UQ/MjZt2f7Rl7jN+GgTj4RyTjHWVUhAgRIsbSyICRlU76bKyd0GLzmALuFkwIfYS5sxUznhwJZiGOUxNtSZfQtxLi/DgdBzi4R0ij7BY6cv3BcLJaTds9DvbHv6zDqeRvlsxXLZGBnZEmgGLUFWtuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138968; c=relaxed/simple;
	bh=Y0FM6IdMTdYxT6n/KJsgMsZ/chZmNYalxNdE7CK3QLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k3X3y1a+Gz4PosaBYclBMXVWE0iZVXd5yE3X1wEB6myzpFfUNfYmHu+j363CF10nnuHSZgHxknYZD3CQSNtoidxksdWjfFvF2MW4Jl42u1mvBzJ6AMfk+Li0lxMuliDqGtGpqCBUp3V98RFgSmzqjdY4nxQ06ByYVkuX+OHFmtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knMx3FpQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knMx3FpQ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ff3d5c6e9eso11001765ad.1
        for <iwd@lists.linux.dev>; Thu, 08 Aug 2024 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723138966; x=1723743766; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7GqKrME9tW1V+rFm/dnRiB8ulNgvrCAADhugetOY0Q=;
        b=knMx3FpQ2DF8egPYoYR6YJqLxXQIIgr3PY2cecILnMPgRBz37pR/CGBbDPo4VQt3qt
         LWf1GadyUrenOI93uV6jUaGZkMcWM02724tlvXwk3lsCxJMv9IXJoAVTBQDqJ+RidYQg
         Ed6Z92z5TQKOlt0LCLa69Q1GMgMl9fs5RMzKBOSmJW3mXSxFNC5D6s9STmYbrUjal/Tr
         usKU0KH6DI6l+79vX7HK97/gfNkMU2NYYBc3nnnqh7coHVqBkD0sLFF4qc3PU1GJpUaR
         VXVGoUMsCIwn6ba2iodqF8p/ETaF049LhZBcHCiKZqmPFSYFhiVlIDGsYsYLO97RVxSh
         4TdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138966; x=1723743766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7GqKrME9tW1V+rFm/dnRiB8ulNgvrCAADhugetOY0Q=;
        b=cJ7GsiHBT8rCZpMMsp0pTrEklyITvXsvP6ywf8/iEeM5+Jfxq80acLOWMkv1rnBcKZ
         52ji5rwjzsJdgTVYInjMqr0YygjDnUcojjCoSoNf/RsrQA1XCKPtUn5MNiRZW7kMNOYR
         UJ5NMsD8LfOgseNJ/JZ5v0Xo8Nzpp/+qCNBRkojjYzqpWu18NyYlLhkYVE1UbWsvwoIN
         0pNaEqP+v6jySqT6G0GbN5uggbG0mXPYYkjWHCBgsQ9m1yFPjdleH2sDmy31h9XjZZh/
         TN0jrceLZNOHqTSh+axt3hNtonQbg/j2as3xEieQT2cLqC/veq7kV1uVPtKbOiJ9yWS6
         fY0g==
X-Gm-Message-State: AOJu0Yw7E97FN99WSt6YRoSVtlEIgzkOY2+I5jdj9K1CWjnD9b9Ukoh9
	KllOHs7E6zYh00RwIIXuVQG93CRHimmPQ0IXGoB+e/BPK585j3Ly+NtZNA==
X-Google-Smtp-Source: AGHT+IEGLLXVPwgV0XEQSYTABpMgqGELgQT763SookvC8db/Lbofc9cW2aykV/cjNG8UXff0ljVVFw==
X-Received: by 2002:a17:903:1d0:b0:1fd:a5a2:5817 with SMTP id d9443c01a7336-2009525fca9mr30710725ad.31.1723138966088;
        Thu, 08 Aug 2024 10:42:46 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53435sm127478355ad.64.2024.08.08.10.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:42:45 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 09/13] client: add net.connman.iwd.BasicServiceSet definition
Date: Thu,  8 Aug 2024 10:42:32 -0700
Message-Id: <20240808174236.218750-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808174236.218750-1-prestwoj@gmail.com>
References: <20240808174236.218750-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 client/dbus-proxy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/dbus-proxy.h b/client/dbus-proxy.h
index f0a5d38a..32300f41 100644
--- a/client/dbus-proxy.h
+++ b/client/dbus-proxy.h
@@ -41,6 +41,7 @@ struct proxy_interface;
 #define IWD_DPP_INTERFACE                "net.connman.iwd.DeviceProvisioning"
 #define IWD_DPP_PKEX_INTERFACE \
 				"net.connman.iwd.SharedCodeDeviceProvisioning"
+#define IWD_BSS_INTERFACE                "net.connman.iwd.BasicServiceSet"
 
 typedef bool (*proxy_property_match_func_t) (const void *a, const void *b);
 
-- 
2.34.1

