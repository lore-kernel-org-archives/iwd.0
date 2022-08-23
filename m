Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474528F9
	for <iwd@lists.linux.dev>; Tue, 23 Aug 2022 16:36:40 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso9899178wmh.5
        for <iwd@lists.linux.dev>; Tue, 23 Aug 2022 09:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=/1XFnE9KahHVp5qRjUDxaBdcLde7GVGNljYv3O35Upk=;
        b=jRmkRTyNqKXyBhv4jIol7RB9pelnvD5140Z+Ku9qtr9SifFN+Nvz7xhMCSpezCwHb0
         Wk+2XDuQYVR4HghomyrwcpRb04yKXr+92qdYoXearUG3MtcFTG1dTvdl45o08U1HQT21
         60u/uo8RKlvU9+gI6h6U5tv7kmSGAKqyKYLs81Vl+YlZ5pI/Ovx2Uec+hJioeYDLDplp
         uRtFWMGjFWx2f9Ps0Iw+De/oPMyHFURJW9AGvie9b8h0vgW49dE4vxw50dVO+nn/03st
         3U/KCqDyrIok42M4ubDuCVtcpB98w9s1VCBJQAyoCyiwBG+CWmmueNXkZBI9aepu+Px6
         5muA==
X-Gm-Message-State: ACgBeo1haMD/Py7CqDDx/C/Vp22FSATSWC0fkDwhfHc7cZSNJHI90fzu
	d9C/nPUOluRKAAJoAncOHQ2eC7g13q8=
X-Google-Smtp-Source: AA6agR67/c9/81Xcs/wTuHXfx4lytoNwoEhXgAzMRHCiSgNd3n6kNnmPznIOLi0v6JwoOhOg21CY1g==
X-Received: by 2002:a7b:cd8a:0:b0:3a5:5000:e2e with SMTP id y10-20020a7bcd8a000000b003a550000e2emr2695577wmj.20.1661272598439;
        Tue, 23 Aug 2022 09:36:38 -0700 (PDT)
Received: from iss.ger.corp.intel.com ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id g1-20020adff3c1000000b0021e5f32ade7sm14716319wrp.68.2022.08.23.09.36.37
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 09:36:37 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 2/3] autotests: Fix class variables that should be object vars
Date: Tue, 23 Aug 2022 18:36:15 +0200
Message-Id: <20220823163616.1466543-2-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220823163616.1466543-1-andrew.zaborowski@intel.com>
References: <20220823163616.1466543-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to those variables being global (IWD class variables) calling either
unregister_psk_agent or del on one IWD class instance would unregister
all agents on all instances.  Move .psk_agents and two other class
variables to the object.  They were already referenced using "self."
as if they were object variables throughout the class.
---
 autotests/util/iwd.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index b17fe163..5f5699df 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1091,17 +1091,15 @@ class IWD(AsyncOpAbstract):
         some tests do require starting IWD using this constructor (by passing
         start_iwd_daemon=True)
     '''
-    _object_manager_if = None
-    _iwd_proc = None
-    _devices = None
     _default_instance = None
-    psk_agents = []
 
     def __init__(self, start_iwd_daemon = False, iwd_config_dir = '/tmp',
                             iwd_storage_dir = IWD_STORAGE_DIR, namespace=ctx,
                             developer_mode = True):
         self.namespace = namespace
         self._bus = namespace.get_bus()
+        self._object_manager_if = None
+        self._iwd_proc = None
 
         if start_iwd_daemon:
             if self.namespace.is_process_running('iwd'):
@@ -1120,6 +1118,8 @@ class IWD(AsyncOpAbstract):
         if self.namespace.name is None:
             IWD._default_instance = weakref.ref(self)
 
+        self.psk_agents = []
+
     def __del__(self):
         for agent in self.psk_agents:
             self.unregister_psk_agent(agent)
-- 
2.34.1

