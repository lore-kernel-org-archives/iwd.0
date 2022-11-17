Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145916138
	for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 15:22:09 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id i10so5875642ejg.6
        for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 07:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8+NdWNbVMLGBz/K9kgXPx3Fm1i9cBtslAtJH6I+y5g=;
        b=bmi6L3JFMprB6/o4KIP/fZAIc1LC92RKHAtR63aVkpYejOpKfdxZa436u0WkGVUs8w
         9vvnZN5T/vYZz64pXvrq/N1krTyZjZla4/knO0oFDno55+TUgL/27XvLFvnb65Jzjp5p
         BxIcEPMEeD4MMk66fC3y6VNszvoQ+B9SiDba0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8+NdWNbVMLGBz/K9kgXPx3Fm1i9cBtslAtJH6I+y5g=;
        b=IleNNCNGAgXh84c5EhQUTdC+n1fdF5xWyPdRq5234UETt+8weJyK+1/kkuXSDJ/7Br
         Q5NMTnswQ16N8sncBWvZ0JXRYeKqLwq+lo/xpjvMHascqKuy8e0YQVuDixVDmJeSXJrE
         8bhPqFQUDyI9RR5EC0WIae5kapYNHPGP96RHKueV2YJCEIFIWWmK+vXRPQh6LKlrejce
         laZIwRNe9Iom7LjQsRusxlyZuR/e1H6EV5HRFtvyLWHJtA6Jx59ZZBzRhsZ6tnWpcYba
         zat6fcvbB6M+rdUuW5pU8PqtccL/RtJIhYx14HMkpbT60rN59LhpgvvLBJZ6hNB/HDzW
         5NwQ==
X-Gm-Message-State: ANoB5pkT8IbzD0/Cn5aSjgbcR9U0uS9k8xVDCZ5jMAysP1Xe5xUYTls1
	A3tiRBpBpaczbg0ZPWgdqFOJ4CQY/zeTvA==
X-Google-Smtp-Source: AA0mqf4zLUiEd2koQRxPIzGNQa10PzvHDN7pvWUawApT5aEbtLgcgfA3yw078X3e0HzLqq4ova9hWA==
X-Received: by 2002:a17:907:77d6:b0:78d:e26f:bfd8 with SMTP id kz22-20020a17090777d600b0078de26fbfd8mr2565139ejc.482.1668698528135;
        Thu, 17 Nov 2022 07:22:08 -0800 (PST)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id r16-20020a170906705000b00779cde476e4sm495892ejj.62.2022.11.17.07.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 07:22:07 -0800 (PST)
From: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To: iwd@lists.linux.dev
Cc: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: [PATCH] scan: make scan requests fail if trigger returns -EBUSY
Date: Thu, 17 Nov 2022 16:21:55 +0100
Message-Id: <20221117152155.2310412-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alvin Šipraga <alsi@bang-olufsen.dk>

If a CMD_TRIGGER_SCAN request fails with -EBUSY, iwd currently assumes
that a scan is ongoing on the underlying wdev and will retry the same
command when that scan is complete. It gets notified of that completion
via the scan_notify() function, and kicks the scan logic to try again.

However, if there is another wdev on the same wiphy and that wdev has a
scan request in flight, the kernel will also return -EBUSY. In other
words, only one scan request per wiphy is permitted.

As an example, the brcmfmac driver can create an AP interface on the
same wiphy as the default station interface, and scans can be triggered
on that AP interface.

If -EBUSY is returned because another wdev is scanning, then iwd won't
know when it can retry the original trigger request because the relevant
netlink event will arrive on a different wdev. Indeed, if no scan
context exists for that other wdev, then scan_notify will return early
and the scan logic will stall indefinitely.

From a user perspective, this leads to a situation where iwd reports
over DBus that it is not scanning, but it never queues up another
periodic scan. Or if a scan was explicitly requested over DBus and the
trigger for that scan ended in an -EBUSY for the aforementioned reason,
the DBus method call stall indefinitely.

Since scan contexts are handled on a per-wdev basis, and since multiple
wdevs may in principle share the same wiphy, solve the above problem by
instead having the scan module simply propagate the -EBUSY error. In
practice this will mean that scans may fail more often, in which case at
least one default error message will be logged each time:

iwd[1451]: Received error during CMD_TRIGGER_SCAN: Device or resource busy (16)

It can be debated whether or not this message is needed: maybe the
upper-layer may wish to implement its own retry logic instead. In the
case of a periodic scan for example, a failure is met with ambivalence:
no additional error is logged, and a new scan is simply scheduled
according to the periodic scan interval. In other cases, a scan might be
part of a DBus request to connect to a hidden network. Here, the error
will be different:

Failure to connect because the network wasn't found after scanning:

    $ iwctl station wlan0 connect-hidden foobar
    Object not found

Failure to connect because another scan was active on the same wiphy:

    $ iw dev uap0 scan >/dev/null &
    $ iwctl station wlan0 connect-hidden foobar
    Operation failed

This is the trade-off made by this change in order not to complicate the
scan context with lookup-by-wiphy and an internal retry mechanism, while
still providing robustness and not stalling the scan logic of the
daemon.

Additionally, in the event of a failed scan trigger via the DBus scan
method, do not automatically jumpstart the autoconnect logic, as this
would not make sense.
---
 src/scan.c    | 22 ++++------------------
 src/station.c |  2 +-
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 5548914a12de..b487c342129d 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -229,12 +229,6 @@ static void scan_request_triggered(struct l_genl_msg *msg, void *userdata)
 
 	err = l_genl_msg_get_error(msg);
 	if (err < 0) {
-		/* Scan in progress, assume another scan is running */
-		if (err == -EBUSY) {
-			sc->state = SCAN_STATE_PASSIVE;
-			return;
-		}
-
 		scan_request_failed(sc, sr, err);
 
 		l_error("Received error during CMD_TRIGGER_SCAN: %s (%d)",
@@ -2094,7 +2088,6 @@ static void scan_notify(struct l_genl_msg *msg, void *user_data)
 	{
 		struct scan_freq_set *freqs;
 		bool send_next = false;
-		bool retry = false;
 		bool get_results = false;
 
 		sc->state = SCAN_STATE_NOT_RUNNING;
@@ -2138,24 +2131,17 @@ static void scan_notify(struct l_genl_msg *msg, void *user_data)
 
 			/*
 			 * Drop the ongoing scan if an external scan flushed
-			 * our results.  Otherwise, try to retry the trigger
-			 * request if it failed with an -EBUSY.
+			 * our results.
 			 */
 			if (sr && sr->started &&
 					scan_parse_flush_flag_from_msg(msg))
 				scan_finished(sc, -EAGAIN, NULL, NULL, sr);
-			else
-				retry = true;
 
 			sr = NULL;
 		}
 
-		/*
-		 * Send the next command of an ongoing request, or continue
-		 * with a previously busy scan attempt due to an external
-		 * scan.
-		 */
-		if (send_next || retry) {
+		/* Send the next command of an ongoing request */
+		if (send_next) {
 			struct scan_request *next = l_queue_peek_head(
 								sc->requests);
 
@@ -2220,7 +2206,7 @@ static void scan_notify(struct l_genl_msg *msg, void *user_data)
 			 * we may be able to now queue our own scan although
 			 * the abort could also have been triggered by the
 			 * hardware or the driver because of another activity
-			 * starting in which case we should just get an EBUSY.
+			 * starting in which case we should get an EBUSY.
 			 */
 			start_next_scan_request(&sr->work);
 		}
diff --git a/src/station.c b/src/station.c
index eab16eff5afa..f12ca22a8648 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3845,7 +3845,7 @@ static void station_dbus_scan_triggered(int err, void *user_data)
 			dbus_pending_reply(&station->scan_pending, reply);
 		}
 
-		station_dbus_scan_done(station, true);
+		station_dbus_scan_done(station, false);
 		return;
 	}
 
-- 
2.37.3

