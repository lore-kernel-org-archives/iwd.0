Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDE44A02
	for <iwd@lists.linux.dev>; Wed, 10 Aug 2022 23:16:27 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id 13so14113557plo.12
        for <iwd@lists.linux.dev>; Wed, 10 Aug 2022 16:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=h8rZW2gOtN49OqCge9lG30TpdQHxK7Xm2nwcx1D/OXA=;
        b=HG43XXOgVsbUqTNWb2qkX5y75RKdwxFCjbrh3HS/YNwF/TQok0AxM5xu4RjqVnPIPO
         e0pFiVtergypeGAKRpxPoRTxK0SYT6e9RdnNsOcb4vwAaCflaICxBO5oL4UznJvOl/hu
         lT4gdHPpkZ3qqdrd24qOUKTiahztY5VabIVplnn45yGZum74r3Tt+erADz1qX3RC3NOv
         IzrNF7DITy1VmHWF5UVijzQ1EQMwzQN0H9l9o7pUAbrVuXhcvlbAdvW7xlXK+y14cTSX
         qnhlZyTV0uhhEhpolPJuRAnUQMrLc/oZWGRoe4hCutwBZKw6F9C/pDgm/ZBXztRVQx7f
         pyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=h8rZW2gOtN49OqCge9lG30TpdQHxK7Xm2nwcx1D/OXA=;
        b=KdtEpNzXwYKeYuwj/moxAtGtxt50do4OiOl2bjrdAfOHbak5X8W+dwUlOhN+5bOK6S
         2fipqVlzl/rPCDtDunr0bcJUKGCcw4HOhtj87mRILvvnh7NAT2wxPjH4dUjW17t9QTtM
         3ZSyqAKS4w11S74Hs/ogfPKpmlIipA7oNYRlDMT38ccDyVue3U0SoeUtYsFfFZKtt7xF
         /HOiAstf+Swm6VZJKYT2BOMe/1CWGFuL095eF++Zc6oSdconWANczJy48lPx+x1KLQBX
         Qa9rDMcpoN3wwwDBw8lkUQYv0UTOJqWJU13OVlKVp5mCkqpkaEr8KtMTLEPDxppnWLHP
         elMA==
X-Gm-Message-State: ACgBeo0dN6ypMw8kViFPVUuh6yPjdeDQgbXQfThIK24lcXgdDX2qIa8d
	HP1fEYfUeA7gXeqGhYgx7oYrVU0NiZk=
X-Google-Smtp-Source: AA6agR4RMP739TS+pS1IkgI64Xjpd9p1YwZWbGQXcpMPzQ3WWAslGJBdDbXoKBQPecuyzU+3C4yz6Q==
X-Received: by 2002:a17:902:b214:b0:171:2e1f:6d1a with SMTP id t20-20020a170902b21400b001712e1f6d1amr6888899plr.147.1660173386548;
        Wed, 10 Aug 2022 16:16:26 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b0016d62ba5665sm13540246plg.254.2022.08.10.16.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:16:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/8] client: add STATION_DEBUG_INTERFACE definition
Date: Wed, 10 Aug 2022 16:16:19 -0700
Message-Id: <20220810231621.372514-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220810231621.372514-1-prestwoj@gmail.com>
References: <20220810231621.372514-1-prestwoj@gmail.com>
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
index 34917e82..0b4fec43 100644
--- a/client/dbus-proxy.h
+++ b/client/dbus-proxy.h
@@ -34,6 +34,7 @@ struct proxy_interface;
 #define IWD_WSC_INTERFACE                "net.connman.iwd.SimpleConfiguration"
 #define IWD_STATION_INTERFACE            "net.connman.iwd.Station"
 #define IWD_STATION_DIAGNOSTIC_INTERFACE "net.connman.iwd.StationDiagnostic"
+#define IWD_STATION_DEBUG_INTERFACE      "net.connman.iwd.StationDebug"
 #define IWD_AP_DIAGNOSTIC_INTERFACE      "net.connman.iwd.AccessPointDiagnostic"
 #define IWD_DAEMON_INTERFACE             "net.connman.iwd.Daemon"
 #define IWD_DPP_INTERFACE                "net.connman.iwd.DeviceProvisioning"
-- 
2.34.3

