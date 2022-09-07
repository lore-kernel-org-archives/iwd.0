Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2828528E3
	for <iwd@lists.linux.dev>; Wed,  7 Sep 2022 23:32:06 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id b144so11350383pfb.7
        for <iwd@lists.linux.dev>; Wed, 07 Sep 2022 16:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=L2oYEUjpHJhK1u9DXLZgXdM7+wd3m+pKR69BD3cJBIo=;
        b=mh4NgfVePQBtQoQhPu9dNNw/ibg4dSX4bGsacDznv/Wiv8YdRAIYZpMuzZ6w3tUjYQ
         koq1yHGMYiHb7WWbflxM+3zxlJ+64JScwMcPO5x+dhD5rzWmB6Z9pAgs+dENGwgpr9IK
         65RMz1eUmPMPD09epJHcUtYnhUqEv9oxye/zng94NFXql2jMkDp30cJkQyBWRoI94x9I
         JVi8siU7VDfOIRX2ehP1tC5NaskpoMN2cadFrjKFO/EsCPL2xRjiEXoD4Pbb48eZb99t
         jJsKGhvsTMMdYdloj08nja5QxvFE+ZIL0Di+6W+GPo/+LWsmzQhMPE+qvdwMa2YxibR6
         Gdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=L2oYEUjpHJhK1u9DXLZgXdM7+wd3m+pKR69BD3cJBIo=;
        b=7haW+9TWTupMz1R4xWG8/MJTFaEFMGHJcGfeA+gAAaoIDwnbLjTFsKw1U/cJIZEbbM
         +pMaA8mOTd3/KKXv+QtvBykcqyHBVWdfT41Z04b5WtubqFsZ5xEL8cnIYz8du/RbI/2z
         oGZ0IYrF/RguJ2WSEIEfib/dcq+i5SoOA2SdVC5L0yCOzGw6ZCjTuZDj/FjVg6Uil9bL
         NyHxN7H5/CysvCz4EWElJwdeX9349Ufg3W6o0OqQw2a5+YBJv2va8IIin9OBvleqXJOX
         r7wtdTJu+6rifBIbZ508F2Suuj7uQTUN50pj78vKAdADzfy8dRXXmbPTvsAEt/fdIrDJ
         qEbQ==
X-Gm-Message-State: ACgBeo29+oqHJw1S/GOwNkuNNxoyp1WfGon2NWn5PjMI3US2ZyQ4oLV/
	ZAsX4CCriuadZMjibIKA8ZthIQ1y0mE=
X-Google-Smtp-Source: AA6agR5sGff42SpBYfzuXNser1z8lw2BKl+j471O/xO1q/niVGicPTY8brMcUsodLSF+At18oykTiQ==
X-Received: by 2002:a05:6a00:b53:b0:537:7f7:63a7 with SMTP id p19-20020a056a000b5300b0053707f763a7mr6235777pfo.2.1662593525400;
        Wed, 07 Sep 2022 16:32:05 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id q24-20020a63f958000000b004348bd693a8sm4918192pgk.31.2022.09.07.16.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:32:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] wiphy: remove nl80211 from wiphy object
Date: Wed,  7 Sep 2022 16:31:59 -0700
Message-Id: <20220907233201.227577-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220907233201.227577-1-prestwoj@gmail.com>
References: <20220907233201.227577-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nl80211 object is already a global and there is no need
to track this in wiphy itself.
---
 src/wiphy.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 28d4b66e..f295d87d 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -118,7 +118,6 @@ struct wiphy {
 	uint8_t extended_capabilities[EXT_CAP_LEN + 2]; /* max bitmap size + IE header */
 	uint8_t *iftype_extended_capabilities[NUM_NL80211_IFTYPES];
 	uint8_t rm_enabled_capabilities[7]; /* 5 size max + header */
-	struct l_genl_family *nl80211;
 	char regdom_country[2];
 	/* Work queue for this radio */
 	struct l_queue *work;
@@ -375,7 +374,6 @@ static void wiphy_free(void *data)
 	l_free(wiphy->model_str);
 	l_free(wiphy->vendor_str);
 	l_free(wiphy->driver_str);
-	l_genl_family_free(wiphy->nl80211);
 	l_queue_destroy(wiphy->work, destroy_work);
 	l_free(wiphy);
 }
@@ -1756,11 +1754,9 @@ static void wiphy_register(struct wiphy *wiphy)
 struct wiphy *wiphy_create(uint32_t wiphy_id, const char *name)
 {
 	struct wiphy *wiphy;
-	struct l_genl *genl = iwd_get_genl();
 
 	wiphy = wiphy_new(wiphy_id);
 	l_strlcpy(wiphy->name, name, sizeof(wiphy->name));
-	wiphy->nl80211 = l_genl_family_new(genl, NL80211_GENL_NAME);
 	l_queue_push_head(wiphy_list, wiphy);
 
 	if (!wiphy_is_managed(name))
@@ -2099,8 +2095,8 @@ static void wiphy_get_reg_domain(struct wiphy *wiphy)
 	msg = l_genl_msg_new(NL80211_CMD_GET_REG);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &wiphy->id);
 
-	wiphy->get_reg_id = l_genl_family_send(wiphy->nl80211, msg,
-						wiphy_get_reg_cb, wiphy, NULL);
+	wiphy->get_reg_id = l_genl_family_send(nl80211, msg, wiphy_get_reg_cb,
+						wiphy, NULL);
 	if (!wiphy->get_reg_id) {
 		l_error("Error sending NL80211_CMD_GET_REG for %s", wiphy->name);
 		l_genl_msg_unref(msg);
-- 
2.34.3

