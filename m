Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC497BAE7
	for <iwd@lists.linux.dev>; Wed, 13 Mar 2024 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350021; cv=none; b=Jkz9H8KSXLl1NokLhq7MvxpCCdla9xhQz9NeNkM/yZCAg+2Dp+kThjep6wRRbd+zVXixy46LVOudskmjyRJl/Z9dbus5H5u2S3DQVPI4b/PcY41sbWkyLinkVTJkIbdilpRezcXw3cIp77lwxYJXNzGtsXv46wUxxHqJgUqp6XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350021; c=relaxed/simple;
	bh=lb9/VaPQdNylr3CnZS/warLCHD/03kqFpnOXWC0cQeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TcXjpxTK/Jf8dJWM2zhKCAr6cbtdRIw5jFb6dDADn4v0zXOwA0JfO0LBA2V9a7PUgBRUshYxDdo3FFshEshiDz96E1imRttsepmuGOBvA68wQITd5YBDE9t3pFB5dn5ZC7+f4YJt6ZukOEuZXSPlEz7MXsOXJYpn2xVh65I4kss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8JAEYcc; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8JAEYcc"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7882b1e87c4so3046685a.1
        for <iwd@lists.linux.dev>; Wed, 13 Mar 2024 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710350018; x=1710954818; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfggQUFqh8R0OL7pLM6apbCSjclCuBMPEFy6joovcww=;
        b=e8JAEYccbZpzAv9y7XnaaPJjzEGVPyuX4DJB2+/qFyP8yG2yHuGGjWcoWCgUhUO4ZE
         N4ldHdayFpx87ssUVdhNrdyQPCX12kt06BhovG0MXlU4ff1544BbW2SP0fYyO2ptg9ft
         EEZoygJmiEJcMutsOuruY4qWooF5b3uAOJ0yUP3g09vIJDraWEXy8shd8mWtBD1a6zKp
         rE+lgk2PPzwmVvL+Pr66nx0wLqwEufUV/JQZ4f7upH4P4a7BQj7iusZRvy3mc79oXsw2
         AIXbUpffitlDSJWmw4WVB5s4wdGuDE8BsOkdcI2xvzhhC7BzRZitIi6hsNwKjTNzJcKU
         v45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710350018; x=1710954818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfggQUFqh8R0OL7pLM6apbCSjclCuBMPEFy6joovcww=;
        b=UcUMz+L8GcQ9y0HcTR0tLnLqQ9DSdZh3SrNEOo3uh7X7waxrSSrBrwxdkBK6fOsYJP
         49Wbtf2GsAedTJbv2S79M663+rEJWLd8LcUwpCdlPWG6yDajh+1xM4VzpTO7V3kAMPJR
         lZBRGC/JOpMhIbdVH6N0xzZrJaFzo8szDtHSvxtaz9sA5ltxG9pgN3xpttkHtLwniSZo
         1e299nIOfGa/oY0Nifby7CnhFa+DF9jdE9NZtvLz7HgUBW4aq7XAB7xa/wAg/ev3TOUw
         4b6ETR9gv4ZbEg4lgmYkQpXwxbPOIWZlYw+fZNwriZKgYxsh0D3dtBpL9sT6Lt8fkYVJ
         8TfQ==
X-Gm-Message-State: AOJu0YxIdVBqWqaw9St+J5tx0tbBBOf4HgqEIabirI4i8EyzwPSkVSos
	Iw994o3Lh2qROz5ZEvrw7ke4FHwnAmekRF9RTGycuovkE9yom6h80JD3h3BI
X-Google-Smtp-Source: AGHT+IEQHVwOpFn4q0x9jThNAr1rtY/5qB3I8lJ+vdS772nllnc+EBQ5U6HGHTE9ZjTOFKns/4wGyw==
X-Received: by 2002:a05:620a:1363:b0:788:2190:d293 with SMTP id d3-20020a05620a136300b007882190d293mr468027qkl.40.1710350018475;
        Wed, 13 Mar 2024 10:13:38 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id i4-20020ae9ee04000000b007882e204d45sm4927136qkg.37.2024.03.13.10.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:13:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 3/5] dpp-util: add dpp_append_point
Date: Wed, 13 Mar 2024 10:13:09 -0700
Message-Id: <20240313171311.695830-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313171311.695830-1-prestwoj@gmail.com>
References: <20240313171311.695830-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Any time DPP needs to append a point it has to use a temporary
buffer to copy into, then copy that into the message buffer.
Instead of this add a special purpose API to add the type/length
then copy the data directly into the message buffer.
---
 src/dpp-util.c | 13 +++++++++++++
 src/dpp-util.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index ada7ed96..81f34047 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -697,6 +697,19 @@ size_t dpp_append_wrapped_data(const uint8_t *frame, size_t frame_len,
 	return attrs_len + 4 + 16;
 }
 
+size_t dpp_append_point(uint8_t *to, enum dpp_attribute_type type,
+				struct l_ecc_point *point)
+{
+	const struct l_ecc_curve *c = l_ecc_point_get_curve(point);
+	size_t len = l_ecc_curve_get_scalar_bytes(c) * 2;
+
+	l_put_le16(type, to);
+	l_put_le16(len, to + 2);
+	l_ecc_point_get_data(point, to + 4, len);
+
+	return len + 4;
+}
+
 /*
  * EasyConnect 2.0 Table 3. Key and Nonce Length Dependency on Prime Length
  */
diff --git a/src/dpp-util.h b/src/dpp-util.h
index 387750aa..1ff9004d 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -151,6 +151,8 @@ size_t dpp_append_attr(uint8_t *to, enum dpp_attribute_type type,
 size_t dpp_append_wrapped_data(const uint8_t *frame, size_t frame_len,
 				uint8_t *to, const void *key, size_t key_len,
 				size_t num_attrs, ...);
+size_t dpp_append_point(uint8_t *to, enum dpp_attribute_type type,
+				struct l_ecc_point *point);
 
 char *dpp_generate_uri(const uint8_t *asn1, size_t asn1_len, uint8_t version,
 			const uint8_t *mac, const uint32_t *freqs,
-- 
2.34.1

