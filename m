Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840524A29
	for <iwd@lists.linux.dev>; Sat, 15 Feb 2025 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739650251; cv=none; b=eurLRXUDiNtc4aZqKYaNAHV7E2YVNXhnd9mnE/vZu2A56cd1pQs/BEKCFBY+M7rOaml3oKqpBryZDL94gBSrx4IhbfhBKd8S731YMYMObFAZ9A3e+9skHyBTW9cne+33NFhQ5pmKfNYMXn3oRIArMlkwx2nqf87UCjBiFgjoPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739650251; c=relaxed/simple;
	bh=FkwoPZhi+lgzSk2Lm2s1rJvebuHSRKJL39+ZqM07BOM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=moZjheWYVkpusMmx2Fh5LzH7Ujm8sbn/TJwWFyNMkDXzVaj579QnSQyuhsQG/FnVcSlJnMw37xuL5j+oROfYrWVuZp3Jg/9sIICyZBryXznwbZ4wugI+EqMSriiQr76S3SZU1mHzeJQkIvpJ99RWjgtbwubO8xWixcycwvPMynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dgtlrift.com; spf=fail smtp.mailfrom=dgtlrift.com; dkim=pass (2048-bit key) header.d=dgtlrift-com.20230601.gappssmtp.com header.i=@dgtlrift-com.20230601.gappssmtp.com header.b=LLdCMqyB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dgtlrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=dgtlrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dgtlrift-com.20230601.gappssmtp.com header.i=@dgtlrift-com.20230601.gappssmtp.com header.b="LLdCMqyB"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f2b7ce2e5so1040697f8f.2
        for <iwd@lists.linux.dev>; Sat, 15 Feb 2025 12:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dgtlrift-com.20230601.gappssmtp.com; s=20230601; t=1739650246; x=1740255046; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+rX+VH0yjlPgHrcDSpuCvetX+bgDI4luPvPHaHZoNM=;
        b=LLdCMqyBpfcstp5kYUWOT/X8cxm3RG+6gEHirLXtmOSrOIbAD2AMlFohdV2p+ZQBln
         VYRzUl/Fb2Ey80+aR9Qun9XGDTQkmfAlKCabgqMT5HgURmaURw0XvVzsxerUkBXOTedT
         VpsIOWRO3zTepVY2+wYkKJlCvaALi2Xj0XS1DhzuQ5cMwZJBSeqqXQd1wVGH1KP1bdMe
         VJGNCxKzKq5EEog/T80NcFhq2uWQ0JuH4jMEaPtnAZ9RCkmxwn75WP5XYtbuko150QeA
         2FSoBIGMI/5vBa5keC3TTGjE8ueB67qp2OFFkfGXFYaVATm7W/TpQoXfNC4NQaKkPUrL
         fqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739650246; x=1740255046;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+rX+VH0yjlPgHrcDSpuCvetX+bgDI4luPvPHaHZoNM=;
        b=KH3CVspvhHw4IQFMYw3vLmH42CXcYS+duozfLWPoLoeWdONianfMNBHq84Cu5+kgs2
         TKBkxvhVz7FSyP08Zy8Zu9OW1ZBf8C2f63dug574eaEsdbyFecEQC9QiOlmK2KFKLTGH
         7tqVmXY6EPPtKpNxS1gg1cgjrzG2M5Mnb1GMvpCAkwe/N90Ctq5zbz6UXMWDlsIouk7F
         oKR08jS9tRM6s3lU5ezTLwpPBjwP4MpaO9rMSooGnw0xOJdBeJ2FNf2QqFa3+CgdN3EE
         jD08Q1YthuK+1n70XHE9LBN/vytVVHMX/ydNUc8Q5oTsE4vKzVbF0Ll5p+NeCPo0H863
         oQUQ==
X-Gm-Message-State: AOJu0YxPXZsKnV/CZfRhRON1P+tke6eYtaUemWM64COLFDnE4U32fTas
	MtIjV8aIiKsFVqxOdP09WyVfyf6LJM9VFbUPQY+rlbSeXCXPU0KBpXzvfnQMvKN5jQrNEcQ52oX
	AkFNQ4scpkVgnX5JWstmYXh1YNmbAaZPeFAN3zC3iU1ScALx+8g==
X-Gm-Gg: ASbGncvKqtNNV1UDtfgtlOj7Ar4M8Fsb62/AvE5+48v/Yz9mHfpuxeXHw73CQJSsqIQ
	PUWXlj+ktIB+UFeL0wpvIiVFoLAVRHHK0EjlDGb87yGSsYe2L2khfz6H47sLROcc2Cj6ffWS4Mr
	bp6X7yK1gSxiGdfsw=
X-Google-Smtp-Source: AGHT+IFj9sNBcTG9e+36hOHaf5EX0pw+WKMYg2fGtO3gF9XYww/TQkF74K2TOtfaSEi18xrFo3PsgjuXU5gYuAs/e3Y=
X-Received: by 2002:a05:6000:1548:b0:38d:e078:43a4 with SMTP id
 ffacd0b85a97d-38f33f5331bmr4364075f8f.31.1739650246222; Sat, 15 Feb 2025
 12:10:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: James Hanley <jhanley@dgtlrift.com>
Date: Sat, 15 Feb 2025 15:10:35 -0500
X-Gm-Features: AWEUYZlvrrs1_qWK9P-2kUpcXk2P_81C0q61d0Wxhp4xyNaEHX35K7D8Bwibu2o
Message-ID: <CAF++6AMG1Jj8cWS0rmSgLPZqCAgRU1o1wgrUaBsOvhGJvrtzYQ@mail.gmail.com>
Subject: Exposing bssid information
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
I=E2=80=99m looking to access (and/or expose) via dbus scanned information =
on
bssid. Specifically, information as follows:

{
  "wifiAccessPoints": [
 {
  "macAddress": "f0:d5:bf:fd:12:ae",
  "signalStrength": -43,
  "signalToNoiseRatio": 0,
  "channel": 11,
  "age": 0
},
{
  "macAddress": "3c:37:86:5d:75:d4",
  "signalStrength": -35,
  "signalToNoiseRatio": 0
},
{
  "macAddress": "30:86:2d:c4:29:d0",
  "signalStrength": -35,
  "signalToNoiseRatio": 0
}
 ]
}

This would be for geolocation services such as skyhook or google
https://developers.google.com/maps/documentation/geolocation/requests-geolo=
cation
to allow a device to estimate its location. It seems that what is
exposed is ESSID information with the strongest AP, or does is this
information already exposed in iwd and which module/interface should
be used? If not exposed, which model would be the most appropriate to
add this to - scan, station, or another - and what interface for dbus
should the method be exposed through?

-Jim
