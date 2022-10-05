Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3509C3217
	for <iwd@lists.linux.dev>; Wed,  5 Oct 2022 22:46:36 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id x32-20020a17090a38a300b00209dced49cfso25747pjb.0
        for <iwd@lists.linux.dev>; Wed, 05 Oct 2022 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=l2vseZCsyMHwcapCQCnNr3fNoeNc7lHETAfsf34Vk3Y=;
        b=egMfI/Bwpt9/ZR81UbWN4To+jwcQm+WxqYGTYpoA67tlgt7F1ZKimV6BMb/ihDe5Pb
         gBD5gPK84+MAoPtvoX42xlOC60zvmlNiBpg74zmSDC7Tk97ceMd/+lCMt42XNEuNP4ml
         Zmwg+31QIvyHBI3EbxQZy+3psg07zS+36CQbcUBhdn2eAIogcyR9rFvwLZ41CWRzv4Si
         3ZcafgogttHJba4nsam+m5vL/QhxobR0FLWeW4upcyAgNIquqRxOBlKVXcmrzq9LdEsk
         YCqb35vpy0727Qo935TSpAqO7l96h4NfK6r2QJH9KBo/G8pRFHqBJtBGK/xKD9eCfUG/
         JHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=l2vseZCsyMHwcapCQCnNr3fNoeNc7lHETAfsf34Vk3Y=;
        b=3vnZtPBK0g3l428E8+emevjsdOfVOvvKOKk0PKBnMJhYlvw2vUfvGMoJ/1AZcxcYPE
         nDC+LtGSId/+9GSq9UXbgY9DpXUZ4mKdpBisz75u+PjCVh3Id8cyWbh9o6roRQlXRwJ5
         D5o8lif9InpYTRVlx5k3MbPQGGAc1lu/e7TLZ303BQ44ObjpHVXsbYSMacYgpY2gjhEu
         Y2qq4ygEY6X68BBLipE4kZtABvc2tC8az20nrijakGyvtPqoUlnyRvWFg1/+RZkkjXsR
         l+ymGocMKVu3/v8uVjOL3+qOOuiCqjJCRwgoVJB6/jwQaCzYQmvGAfcUxekwQVydJ1jE
         4uag==
X-Gm-Message-State: ACrzQf1EgCyfJRSnOcMx6sx8CYRp/L4ucLqePsacHWf3z2FacssagWWl
	4DO2bxsaW5d+U0pXv/LXfCj7Qq5GqBc=
X-Google-Smtp-Source: AMsMyM5S+4EaLfRPS//o7VRPsCzsodDcLODha5v0X0AP/3gzhmMrbMwiuNJlB7+yZeziM6fFGq3XxA==
X-Received: by 2002:a17:903:41cb:b0:179:e709:df5 with SMTP id u11-20020a17090341cb00b00179e7090df5mr1491954ple.57.1665009995354;
        Wed, 05 Oct 2022 15:46:35 -0700 (PDT)
Received: from jprestwo-xps.none (h67-204-159-212.bendor.broadband.dynamic.tds.net. [67.204.159.212])
        by smtp.gmail.com with ESMTPSA id 61-20020a17090a0fc300b001fd7e56da4csm1590686pjz.39.2022.10.05.15.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 15:46:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/6] station: add two debug events for FT
Date: Wed,  5 Oct 2022 15:46:27 -0700
Message-Id: <20221005224632.780575-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These events are sent if IWD fails to authentiate
(ft-over-air-roam-failed) or if it falls back to over air after
failing to use FT-over-DS (try-ft-over-air)
---
 src/station.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index fdeab7c1..1ebd13ad 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2293,6 +2293,7 @@ static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
 
 	ret = ft_associate(netdev_get_ifindex(station->netdev), bss->addr);
 	if (ret == -ENOENT) {
+		station_debug_event(station, "ft-over-air-roam-failed");
 try_next:
 		station_transition_start(station);
 		return true;
@@ -2337,9 +2338,10 @@ static bool station_fast_transition(struct station *station,
 		ret = ft_associate(netdev_get_ifindex(station->netdev),
 					bss->addr);
 		/* No action responses from this BSS, try over air */
-		if (ret == -ENOENT)
+		if (ret == -ENOENT) {
+			station_debug_event(station, "try-ft-over-air");
 			goto try_over_air;
-		else if (ret < 0)
+		} else if (ret < 0)
 			return false;
 
 		station->connected_bss = bss;
-- 
2.34.3

