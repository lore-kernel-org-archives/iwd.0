Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B23F1CAAD
	for <iwd@lists.linux.dev>; Thu, 20 Jun 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899112; cv=none; b=uMv592iKANq6SaBvctE3aPcNEote5Q+ZsdSEnsgJMESMqdBQHpkLix7ExIaUMrPyjCCPNK+oTmNPf1y0nBNh9wb3uDoM/qNpnCzgAOia8vNynbgDQWmIjXf5njWoeKMYgFwEaiu2MnlDNj1auPImjjuM7/Piq2NdhrL1JcTsuiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899112; c=relaxed/simple;
	bh=jH96DK9OlH5lhk+DBnxG0XNKIAgvqYLpkS29kpbFNrg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ppNMOQV1EtpUHxD8nFp1b44vThgDlQYhMnm2F4Fw//wgzjkCVt79jdFDCTSnq2/p/rAJiSdfa+5vsqDyO8YfoGc7qpUX6VTl4hWLJkWXBsT3fiihRaw96nKyviv+dV9qf8wuKHXKpwHwwpYSGBKZunA58oJINU1LZKjDEDQ9Y4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EO2HD4HN; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO2HD4HN"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7152e097461so365340a12.1
        for <iwd@lists.linux.dev>; Thu, 20 Jun 2024 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718899110; x=1719503910; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jH96DK9OlH5lhk+DBnxG0XNKIAgvqYLpkS29kpbFNrg=;
        b=EO2HD4HN4NzKL4c2T6i75179+1rzVNgvaPVGPBzKkDAKtKNJcgC0L2l2XcKsk3NL30
         B3MwLrCGYY+YUGxmcA1qBDaTwJBU2AznJr1WD5d8amhjDFK+QdxJK1WVPx4wG4Aj68t4
         dJxSFgcmH0t8Tug6pkPXVyRhjYVgymWroBGMEYwQoy2PhYbwXwKhQnvHvJZ0odPXus/e
         +6yqggZr8I2zJn/xaG37uTrZh1P7Qc6trEprV8vXJop+cI/FXQGCwDnHFVuJNKF3B1mp
         sj0uNmBo38rXpixm/vrVkwMd72itAkVO6S+/9kCbh7rVbY4bjQt6VtWPUOzVF6RSOGBO
         g7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718899110; x=1719503910;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jH96DK9OlH5lhk+DBnxG0XNKIAgvqYLpkS29kpbFNrg=;
        b=EV8P8YgCVaDu0xriE5NW2RoBy5MK+sMoM1fWbtYr2dWCBiNifpI0ip5FA4UldVepaO
         w0n1v1VJaP88q1b+cCp8ZFi4SCoM8W1n/wtQC3ufOixlt4gCys5hpV1lK5X8jUoAJbui
         lIcd/2bTxqhoH4cNmoOuHpre4LReH6zh8Tkq00JDam4DsUNn3oezfW/PfNNxFqPusqMT
         0aTBjNPpv7FY0YkC03muQxQqp0s5qcLoGK1zbgXvi3QU8vX8NW6eKXuEg2KchT0dVTH8
         /D/htso5cvHEyEZfEF3gryR3SNPzsTAoE03WWXm0vLTOsrpW984tIaYx8h8yEHCDNUWA
         vUSA==
X-Gm-Message-State: AOJu0YzGc/8ba/aUxr67HMCRFW5t9nwmEn/t6E8vwaFJN7TYIZgSB/gY
	+t/UeLMbBjuvEFjaxe+Iq0ZGMwG5caFcpQZEJggmthYJsALYQ0BUOnHfA8ty2eaVzuxPoEjf9cV
	KK04WUw2MQ79gvorOAuMtrUVcABMp/jBx480=
X-Google-Smtp-Source: AGHT+IEj8X2hw6iym5MOqjZfhzy8DqF0omsi7j0M7jao15DQdCDbsdM948qtXkTtYsh0L5Eh87XXRbM3DEgmsE/hlKw=
X-Received: by 2002:a17:90b:711:b0:2c4:bdc0:a29e with SMTP id
 98e67ed59e1d1-2c6c8936548mr12240190a91.3.1718899110002; Thu, 20 Jun 2024
 08:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 20 Jun 2024 10:58:18 -0500
Message-ID: <CAG17S_P52iGw9j12MrP0OwL7ZxENH6gj17er1vXR58R3qRS3Kw@mail.gmail.com>
Subject: SAE/WPA3 in AP mode config question
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Group,

This page shows how to set up a simple ap config:
https://iwd.wiki.kernel.org/ap_mode

The AP using this is set up with wpa2, I believe.

How do we tell iwd to use SAE/WPA3 authentication in such a config
file? I also did not see a flag in the help on setting it while using
iwctl interactively.

Regards,

Keith
