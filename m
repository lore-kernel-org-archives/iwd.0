Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE765F1F6
	for <iwd@lists.linux.dev>; Tue,  5 Dec 2023 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLZ9xprO"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-58ce8513da1so3895725eaf.2
        for <iwd@lists.linux.dev>; Tue, 05 Dec 2023 07:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701791222; x=1702396022; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iT7ctme1sO4Kp/oJ7668iSMaXw1fmh4u3UXz4NDSyDg=;
        b=CLZ9xprOkjYRSAJEKgqIr8Ddgj4AfnyDnx8ydx46FHTalIdRmgDE0+4a7Kkr8X4xrc
         pMQfUe3i3iXixsGt6L9GguIfw/PiJTsc3RIZOsVYseH9oFL3QIgI1mNLDmAyApeYw7fp
         RgIlylP7J2NOZWe5Kiw1JSYlgZlhWkkG1oUBFNDeU+w/vXeH16O2SZNR3JLYgpHVV/aa
         9RUauJm8LeUOuRM8NbGFKm8Jpdz1uu8LBZAWzI4QflZz5493apt5cjdBlFKj+yeyLHUl
         C/i6btfxyHV/y7EoajIkzmnhCnagP4U0OevMbd6TZ/9ISQuBAkF01WavSiThmiZ9Dxee
         XyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791222; x=1702396022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iT7ctme1sO4Kp/oJ7668iSMaXw1fmh4u3UXz4NDSyDg=;
        b=wGddFkGNTGmx8nmeVhKKpy2NjsRJ12boRGtck+EXz9jUQB9xBxP49k3nkyaSCxFPP5
         A3Bbvmy6ih4vsJp0gVg37L95/lyyKpKsfZmoxnOkBpYks+YBDBKyKZKsRfJ38fWukbyA
         ygnF3ti52z5vqfJV7Dqff1ADvpIgrcVTLWSfYNgGwEHBlIhGKfSX+M/T7QuvdlRrX53G
         iloAdh0onHBFC8iRvzm4WeAGoDO7GBTjZh/a/h62asNlWiMPYMzB97ryO/eCGGQezy21
         uxD0ybc7B7OT2PFLlNRqeuD9yEi4ehxsq2EM8cMxX4dGobFrsmznEd3Je9k2i4AHJYNy
         BjnQ==
X-Gm-Message-State: AOJu0YxaN/N6EEphJpZRVoUi3MiOExGrFoP6ioSe9XdDBdQGkimAIUQW
	WRmlAJuwUs1lSRDvnEoBxpOyg9QsQec=
X-Google-Smtp-Source: AGHT+IFWpWEyK27UGR6odkVUGIoIoQWkQkWqG5VE9VKotp5jGeBBGoo0edPR8tzlu++37umPnKocjw==
X-Received: by 2002:a05:6359:2e83:b0:170:17eb:2052 with SMTP id rp3-20020a0563592e8300b0017017eb2052mr5106899rwb.59.1701791222715;
        Tue, 05 Dec 2023 07:47:02 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id kr3-20020a0562142b8300b0067aad395037sm3177567qvb.60.2023.12.05.07.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:47:02 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/10] mpdu: add unknown password identifier status
Date: Tue,  5 Dec 2023 07:46:45 -0800
Message-Id: <20231205154647.1778389-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205154647.1778389-1-prestwoj@gmail.com>
References: <20231205154647.1778389-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/mpdu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/mpdu.h b/src/mpdu.h
index f6f19744..cf3114db 100644
--- a/src/mpdu.h
+++ b/src/mpdu.h
@@ -231,6 +231,7 @@ enum mmpdu_status_code {
 	MMPDU_STATUS_CODE_ENABLEMENT_DENIED = 105,
 	MMPDU_STATUS_CODE_RESTRICT_AUTH_GDB = 106,
 	MMPDU_STATUS_CODE_AUTHORIZATION_DEENABLED = 107,
+	MMPDU_STATUS_CODE_UNKNOWN_PASSWORD_IDENTIFIER = 123,
 	MMPDU_STATUS_CODE_SAE_HASH_TO_ELEMENT = 126,
 	MMPDU_STATUS_CODE_SAE_PK = 127,
 };
-- 
2.34.1

