Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268EE1D5147
	for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769784201; cv=none; b=Z7wmMLUcVJJ2ocWAVXCIPb4Q7ws2kNByDFspT7yy2mJNSoSfdt4ZVtA5oNQyFdhW1Paw1r5xQjlxl91r3WgtCL08T1xNkrP452bG3gm+cLu1ppf6BvvKU1ciha7HRcaZLx5AU/s9duZWsHT0jqY2SZ+wESqPnHXo9msrD8nDiK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769784201; c=relaxed/simple;
	bh=kmzrFzdf5W39dnThhTyps47PdLoGATwoml8VaI5RWQw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=i/Uewebq0Omu8auQt4usln5OuobjuU7iNNVGOuno1+r3sY7NkmCh5CmFLfCE38yqHSFr2Jxrlh/G0N0XyRD80cjpNGkUkFdzI3nhmFjMd1IcI5G120bwtAs7Yx1ySVyyrARJk7Zog7dlzSCEBX46O+W9VLqIaXVZuNdSYQqZyLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-793fdbb8d3aso20976617b3.3
        for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 06:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769784199; x=1770388999;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJsTl2dlyCmKY/Jha90vpva2+AvJ0Ohg5sncJ9084D0=;
        b=IdplPJ7YBUC9HAb+YuAbuD0SQlu4DtwSMBrFl4zzKvbcKRa3XE8dkfpKmAW8yfGvuq
         lmETumEB+Mcu6k0pEO/rCJ2zYQQjkGhtX9PsUpXRi7UXvSzwJRu5As3DqhmUoLFaZm8j
         hTUXkYz9mQHqVTB4BSfDxPl6xsxjinBVrPz8lEalg/zzh+Zgg2/KOR7Vrh/vT/SqTVi0
         PfndJA6eRh+KdLo75H5M02vwVf+XIbst80zY9hidLdcedIAjCUcYbhrJck+7HD5Q5nnx
         77XewKrwwOgL7J5XVE+uqM590zKyOgh4Dk/OhCngAVqAZDCM/US1zvGWwmvgPBBT73e+
         GTfA==
X-Gm-Message-State: AOJu0YxExo4fSneTRXkXp+t27qkmNR7y2ZyvmlfgyPmIYTYgK6lskjDq
	pr2a5JGQOIf8nQCREDp/E5bbWx2gCkcxDJtERrFFid45WUQzli0Iq6YjZ14H9w==
X-Gm-Gg: AZuq6aJiwbZBE4Ww/ildbHKmkN3C8vT0ay/EBKZUUTaOJu7pv1sfLjKz3x60eDy5/iI
	KqCkY9E9Ua+l0mKWJYGI9DlYEu/vgbXa5AH16CR1rewQxdjY86tUcW5QpQ0XeuCYR0LEKRMikKH
	RZs5XIO15rIAmskhzwS7GaYSkjOTuYzM0j+AX0mXbyL4Woq1fgneAvS7HqeWFbLHwm0Jyi3mE0N
	AJSaCwptO6Xue6mDIo/YuGePCeUyPaPzHpv5K8wbdjol7g3ubiSIg4CNj7QbJFDI3crn8QJZ9JC
	vABwpGXtEvwzFf8q/p1Oem8qAjOi79Y5ZeVzRcG8fx8hiyjYpIjq5D7KMfvTSrgyBaBMj+ozSlZ
	HXgI9v0djh8sTss5e9ZFGId9QVLCaBVMnu3lO4ZF7bV7T3qccwDaixTdriV4RpTiZGU8QROH4CH
	yvNpo6trBweeQ/c1STx2s1SQPMSdNiql7qvmmGL6MpOQIEmHf6RQ==
X-Received: by 2002:a05:690c:4d43:b0:78e:1aa5:e96d with SMTP id 00721157ae682-7949ded8a57mr28608087b3.19.1769784198966;
        Fri, 30 Jan 2026 06:43:18 -0800 (PST)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com. [74.125.224.41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794828a9d1asm36290287b3.31.2026.01.30.06.43.18
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 06:43:18 -0800 (PST)
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-649523de91fso2037826d50.2
        for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 06:43:18 -0800 (PST)
X-Received: by 2002:a53:ebcb:0:b0:63f:ab00:1a07 with SMTP id
 956f58d0204a3-649a84b97d7mr1644233d50.49.1769784198257; Fri, 30 Jan 2026
 06:43:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Fri, 30 Jan 2026 07:43:07 -0700
X-Gmail-Original-Message-ID: <CADXxVSJ5FrxYs_s_tz5y6LeGbVLnCgJP3YO8TQEXTnXs+rFuug@mail.gmail.com>
X-Gm-Features: AZwV_QhmFN3uZLuDrQwPCCFR-WRlBg76vBXQmNZngSH9NGoEDrA-suThvP4mJBc
Message-ID: <CADXxVSJ5FrxYs_s_tz5y6LeGbVLnCgJP3YO8TQEXTnXs+rFuug@mail.gmail.com>
Subject: Is there a way to manually force the security protocol with IWD?
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi All
We are working to get our product through wifi certification.  Our
testing company mentioned there was several negative test cases that
were failing where IWD was connecting anyways because it would decide
on the security type based on the AP.  Is there a way to force IWD to
use a security type that is different than the AP so it would fail the
connection?  Can we disable WPA1-only connection or force WPA2 only
connection?

Thanks
Bryce
