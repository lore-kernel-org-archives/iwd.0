Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415F81F945
	for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXTmDS2J"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b5714439b3so328367b6e.3
        for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 11:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698778083; x=1699382883; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoiuoFcTxzf6VnkSfNm0cWT+3q4sx5F2qqAR8TJx2Ag=;
        b=iXTmDS2JI+3QTjofPHlzA81JIj7TetL25wvpgA4LucOn0XPovYMsb2IWuxu+RaHBhK
         lyg1q56cNL57aQavLpgCGWe2DsOeejvXm2gowwksO9HeNw1hzXSBNfnN8553e97j55bZ
         LbHKlu8E7yIMwdYdpT6NuERioIK+UPLEesvAt2iPbSoUJV1dnpxNpvWnGqrRBPZMI6DH
         eEeZMksBav0DG9pZWsLi2+AghTpsAmNdTtapr0ZcKiNHf6UkEbFzsE7oUmt4PV7RDjTi
         V4gCnv9VmIj5JGEuX8QHY3j2AFMzGNBO/41JcoeLxw8lLC5PI+8B5sT5W2MTjD/1lBMP
         yAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698778083; x=1699382883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LoiuoFcTxzf6VnkSfNm0cWT+3q4sx5F2qqAR8TJx2Ag=;
        b=jd903//EIuEdfi802Y1jI+DmYlRsjIzJtNJf7Fv+gWAaVUwYP3/4YYFv9fNrYJMU0T
         SahGAcUINZ/JFZfYRadceecQaNRejOVnjzGAcMErZJeJiYeZwOIHftZ+AIjXmbZNTZTs
         tDSI/Ssh5juSQCKZIHVZ1BCL5giydlJSvDGvyPbFNeGt9rdM6IJ+LoZiFBXDGWUwNyBD
         PrzC+bPRtL38AI5uNBoShX5/dDi7M9XQ2sQ6vPvoChUiSTNg6oABB2wD08bL/gNvAOK/
         3hkemwJJav7vcC4DAGfByFeXPekILYGA6bVTnCrUR7gP5QyY629QZID7/iKwDDvQdqHW
         UmaA==
X-Gm-Message-State: AOJu0YzH8gIOstO6+Eprq6Ylllt62VCNAKlUOIuD8jYdVXoSuFMtj4xz
	ICekAOTUBwvGlQwuKz0MFQHguY2r+rM=
X-Google-Smtp-Source: AGHT+IHk2caivqTAw5NoOkFt3BGB1rNPlzj+0pv9xiv+H/0ZxMqInfCu7szfEhPuBr4e++QkiiXyWA==
X-Received: by 2002:aca:1c03:0:b0:3a0:38c2:2654 with SMTP id c3-20020aca1c03000000b003a038c22654mr11605543oic.58.1698778083007;
        Tue, 31 Oct 2023 11:48:03 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b00774292e636dsm736351qkb.63.2023.10.31.11.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 11:48:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/9] dbus: add net.connman.iwd.SharedCodeAgent DBus interface
Date: Tue, 31 Oct 2023 11:47:45 -0700
Message-Id: <20231031184750.722404-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031184750.722404-1-prestwoj@gmail.com>
References: <20231031184750.722404-1-prestwoj@gmail.com>
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
index cff64ae2..b43412d7 100644
--- a/src/dbus.h
+++ b/src/dbus.h
@@ -47,6 +47,7 @@
 #define IWD_DPP_PKEX_INTERFACE "net.connman.iwd.SharedCodeDeviceProvisioning"
 #define IWD_NETCONFIG_AGENT_INTERFACE \
 	"net.connman.iwd.NetworkConfigurationAgent"
+#define IWD_SHARED_CODE_AGENT_INTERFACE "net.connman.iwd.SharedCodeAgent"
 
 #define IWD_BASE_PATH "/net/connman/iwd"
 #define IWD_AGENT_MANAGER_PATH IWD_BASE_PATH
-- 
2.25.1

