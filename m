Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EDB4C9F
	for <iwd@lists.linux.dev>; Wed, 27 Dec 2023 06:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD5YdU3r"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dbb650ad59so3120479a34.0
        for <iwd@lists.linux.dev>; Tue, 26 Dec 2023 22:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703657441; x=1704262241; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uBdQQdJd+ZqxAmYPvLnInlpThFDN9Oc3DsIxNjHPCw=;
        b=RD5YdU3rSFKCZjy338rAz2qNWQgCWD8cRGl04Av985Wt4mSId0HmZH9uv04/7Z8F2d
         01T47o8LZdKmJqrMIBlABaPNbnx6KGMNy0Kfvac2nJQThTyw/xlJURT9gs5xTeNQmOQP
         jmkUIx94fg9PNwQmWex10H1uu/6Mq27tNlbMB4lWznc2wRJW5uKAIMZIWZx6mFBacmr0
         HmCQqBjDtt/y8hrq629GWC97pUPdNi62/xcGd/MPpQCgMfB4Fap3hS5+hjP89RUW8ZeC
         PwZUv/QGJ8tFqAzHk/KUjHU6huHcMzqaccWJUpYUs7wmWrJhP82xjvAWsfaE3cmLkZJ5
         Zi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703657441; x=1704262241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uBdQQdJd+ZqxAmYPvLnInlpThFDN9Oc3DsIxNjHPCw=;
        b=JjdQI5RtwxcZ5cQkuMt1BfE/K0vhmIsFsrLkeeO6YcVAR0i/MZXrp5+f5BHRXEMlIC
         TDh5Slt1JR7gMcKoz3VsIHWA7iaUrrlapSHHiUd74m3s6nv47+8UphI776RB/CI/o+yl
         M12ZuSsJSSQ718ffXx0gAAEQnHyWiwTO8xY5USQRZHtNQTxr5KMXnlY9bPzRv4d4YLX9
         7vn4S6ARXDkEGN7LJN/2omuA4cjgqsLrIMsZRmt26gCH2iaHtg7NOKAZq0//v7Bu7nRA
         1RgFuTa3XNaZnU6piCCcgJqV7qLRTDY/r9IxCzdqBXklLbnd5ea/BzFKHG1kG3YZtjb/
         C7Rg==
X-Gm-Message-State: AOJu0YyQifZAgeCTCOgBxe+XRGWhNGQSMovVYUmOf3jCo6V1nKvk0orC
	8zoWJocQNr1pcqg7Gen8OR96DXhIXgY=
X-Google-Smtp-Source: AGHT+IExjZcUqK+6Ny+T87zKaNP+vUUURh105ikWAjPJN9d3o2wYWtw8chUma6LiRoLY17fCmT+SzA==
X-Received: by 2002:a05:6870:c1d1:b0:204:508c:efc7 with SMTP id i17-20020a056870c1d100b00204508cefc7mr4308385oad.49.1703657441640;
        Tue, 26 Dec 2023 22:10:41 -0800 (PST)
Received: from localhost.localdomain (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.gmail.com with ESMTPSA id vs7-20020a056871a10700b002032bb7895fsm3048841oab.55.2023.12.26.22.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 22:10:41 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/5] monitor: Remove unused PACKET_AUXDATA handling
Date: Wed, 27 Dec 2023 00:09:47 -0600
Message-ID: <20231227060954.103572-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231227060954.103572-1-denkenz@gmail.com>
References: <20231227060954.103572-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 monitor/nlmon.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 7f8ecdaa1996..b4d1f54c7579 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -7240,7 +7240,6 @@ static void store_message(struct nlmon *nlmon, const struct timeval *tv,
 }
 
 static void nlmon_message(struct nlmon *nlmon, const struct timeval *tv,
-					const struct tpacket_auxdata *tp,
 					const struct nlmsghdr *nlmsg)
 {
 	struct nlmon_req *req;
@@ -8181,7 +8180,7 @@ void nlmon_print_genl(struct nlmon *nlmon, const struct timeval *tv,
 		if (nlmsg->nlmsg_type == GENL_ID_CTRL)
 			continue;
 
-		nlmon_message(nlmon, tv, NULL, nlmsg);
+		nlmon_message(nlmon, tv, nlmsg);
 	}
 }
 
@@ -8194,9 +8193,7 @@ static bool nlmon_receive(struct l_io *io, void *user_data)
 	struct iovec iov;
 	struct cmsghdr *cmsg;
 	struct timeval copy_tv;
-	struct tpacket_auxdata copy_tp;
 	const struct timeval *tv = NULL;
-	const struct tpacket_auxdata *tp = NULL;
 	uint16_t proto_type;
 	unsigned char buf[8192];
 	unsigned char control[32];
@@ -8242,12 +8239,6 @@ static bool nlmon_receive(struct l_io *io, void *user_data)
 			memcpy(&copy_tv, CMSG_DATA(cmsg), sizeof(copy_tv));
 			tv = &copy_tv;
 		}
-
-		if (cmsg->cmsg_level == SOL_PACKET &&
-					cmsg->cmsg_type != PACKET_AUXDATA) {
-			memcpy(&copy_tp, CMSG_DATA(cmsg), sizeof(copy_tp));
-			tp = &copy_tp;
-		}
 	}
 
 	nlmsg_len = bytes_read;
@@ -8261,7 +8252,7 @@ static bool nlmon_receive(struct l_io *io, void *user_data)
 			nlmon_print_rtnl(nlmon, tv, nlmsg, nlmsg->nlmsg_len);
 			break;
 		case NETLINK_GENERIC:
-			nlmon_message(nlmon, tv, tp, nlmsg);
+			nlmon_message(nlmon, tv, nlmsg);
 			break;
 		}
 	}
-- 
2.43.0

