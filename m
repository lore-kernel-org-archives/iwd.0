Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CF0747E
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 18:57:01 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id d24so15079905pls.4
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 11:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIgRqGArK5B+/w0o2+geS6XuqRgSUy3VsKX7mWlL48g=;
        b=SQ/neGTPsjVcNzCOxobeX3iNnbvQLSJ6vNjxCmSZoEqHbwalGAVUgm30dHj94Ujubj
         3iFhP9kn8+DQkbCUhaCp434eFxxVd6jtDK+16TGtnO1iggXw+jHtveButA94B45H05Po
         0p7YVSVmJ5iST5+dhWmd9OLkBROiB422vMf99rvykyaQHGAONg+1iLEJV4lze7GRhpSf
         rRHi34qMYq6/FTLNXxqRdUlNYaPqFACbKn3C6+3jC6NC2LB6eZlsD2C0qjb56ygc1Zb4
         qgZpscq40DSEwgReL+JCh+JByQrShD7zef/HXki9hKc9EEm2oqHypchAStzLzstWWbCG
         hAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIgRqGArK5B+/w0o2+geS6XuqRgSUy3VsKX7mWlL48g=;
        b=4/PYL+xdSWyGnqTJB7gmvbMEULmh5raQHn+ynZHQN+Uel91pQdeAHabZndk44dWjmD
         p2NZAAHgzUhWXO5tIBta9P/JFfg3EVeHsWqq00oVRfWQ0HDIahq/g26PeRbZl101sExo
         wgpd8QzSjbd3TQ5CkZXmxPO8zvGcXjvjuuusTda9OV7hbddHCp9rqFkWxaUB9lPxW9oo
         U/LZZ2UvyY4h3bgvYTmF/uSKg6uauei5DOj3Ira9O18NJDjiO7FI+0yhvd9jcUVr7Umi
         ONn19SJXQSRMkGMjK/uKnlOxOlrdCVCp01+6y5/JUtWqTZLif2AKqVTLHvxoipFd9N8U
         UUFw==
X-Gm-Message-State: ACrzQf2/5QKgmOBi9BI8ZICqUk22YZrzFe/ClCB3wmBYNXlxA0TM8oeU
	G/e2rXmDrHiyt2fzyeI4ML+x6/2s0gQ=
X-Google-Smtp-Source: AMsMyM76KBFckKLqSWr/K+k2mMvuH5SnKU2gJbIlo1FXEoFePz5Oyqwy//ae7W5IdD4jno+j63Tv+w==
X-Received: by 2002:a17:903:2c9:b0:182:c500:d93d with SMTP id s9-20020a17090302c900b00182c500d93dmr46618554plk.44.1666810621316;
        Wed, 26 Oct 2022 11:57:01 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f7d300b001869efb722csm3209420plw.215.2022.10.26.11.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 11:57:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] auto-t: allow printing devices in AP mode
Date: Wed, 26 Oct 2022 11:56:54 -0700
Message-Id: <20221026185656.489888-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221026185656.489888-1-prestwoj@gmail.com>
References: <20221026185656.489888-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __str__ function assumed station mode which throws an exception
if the device is in AP mode. Fix this as well as print out the mode
the device is in.
---
 autotests/util/iwd.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index a9e2f2f5..9e96382a 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -690,14 +690,17 @@ class Device(IWDDBusAbstract):
         return self._device_provisioning.stop()
 
     def __str__(self, prefix = ''):
-        return prefix + 'Device: ' + self.device_path + '\n'\
+        s = prefix + 'Device: ' + self.device_path + '\n'\
                + prefix + '\tName:\t\t' + self.name + '\n'\
-               + prefix + '\tAddress:\t' + self.address + '\n'\
-               + prefix + '\tState:\t\t' + str(self.state) + '\n'\
+               + prefix + '\tAddress:\t' + self.address + '\n' \
                + prefix + '\tPowered:\t' + str(self.powered) + '\n'\
-               + prefix + '\tConnected net:\t' + str(self.connected_network) +\
-                                                                            '\n'
+               + prefix + '\tMode:\t\t' + self._properties['Mode'] + '\n'
 
+        if self._properties['Mode'] == 'station':
+            s += prefix + '\tState:\t\t' + str(self.state) + '\n'\
+               + prefix + '\tConnected net:\t' + str(self.connected_network) + '\n'
+
+        return s
 
 class Network(IWDDBusAbstract):
     '''Class represents a network object: net.connman.iwd.Network'''
-- 
2.34.3

