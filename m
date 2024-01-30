Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B654966B49
	for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611742; cv=none; b=uHgausDggPYaiies5ha4i7bLPHCbJnvQvt+nSQ0d+o6EY4ACNRDP1MlQ6009odifgeXyTCI4IjDN8jMmDcWwPWvX/rYPrbHT9ToxO5y7KRwGVTZvE4uhs6CpcqAMRnbTkLOjSZi0jB5ubuVCLBpirIavNpDcMZPtSj5rC0cBWK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611742; c=relaxed/simple;
	bh=HVM+xEoUpmfjqmO3hZcwbUytSMEqQFMuUxklY9dzGNk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CItTDkTCvMoti5NOWLvVo6NPAzji2gfjaEH/m+rMdUbhOJ1g1hbvqkM57rizqCSb4h1/th2SoV6pXqGdAyk1fJ/ROntzzsjrVF74UlVaZaAvBj05AxmtMWmWm0DT5pLnwwngw/tjTwKXFaxiXAtTxWfHzZJ2Mb+DgFViIAzuQ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PImqPZ+5; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PImqPZ+5"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc226dca91aso3836875276.2
        for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 02:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706611739; x=1707216539; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HVM+xEoUpmfjqmO3hZcwbUytSMEqQFMuUxklY9dzGNk=;
        b=PImqPZ+5GCtjZlF4mawSEsUs2e/qZvUUQI/CGbqct9f+nOSD6sjyyVgoutuBlEdrkV
         PkodQPg6PelYjW9bCx7twLcWh72saxuFedIavWG2wxLb9DBeJlO69MPp70Kl/bzkm5Ob
         18pmvbPnaXLfu8ToShEFr13kECf66mKykWh6gNNCY9jhgf5PXObRcc1uh3CrXaxN95GB
         NkRS8uDjGDAnHSplHWcMnEvmyOAgjxpG2iTgERcgJuCwl5Vum1UCEZjHtZ2D+0XNYwQt
         7aMLP6E/hd2YRUb0F5Y/uJpuM8ZwZ0JCkFR+FBSN/Cnmj6nLQYsZqpD5Ulan+Nick0GA
         brXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611739; x=1707216539;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HVM+xEoUpmfjqmO3hZcwbUytSMEqQFMuUxklY9dzGNk=;
        b=xOX2TBeytYxdVSeENnC4+ybPsWahKhvikqwjbLpAPAdvR42zZsGSrierthPrazTbHq
         HOY7Of9kc1w5/3gaglot2p4AybJ138RX9I3qnmY6AmUfIUyn+9tGvp/1GBhWKsmgHIFC
         3hcFLNeX1WMq+kyjLxKe//mobnUQe0r8vO8/Z8Aj+1HaaqwbFBfkCd4ix5hEMxTpqtmC
         xCTcnxGdMaleyiE03/L8rL1GnuprwLuCBg9hlD8vCSFjHde+V31RBC++i7fZGo9zkefc
         99QtOc+HwGc4SwS7THjZLmeNknl1d7xTsV8s+VT/Z+yAANPtf/g728DJdcwBqg2tIHNx
         wGZQ==
X-Gm-Message-State: AOJu0YxZHoHJCHBePXUroaopofystJBoP15DRsbKkErir7bsdaRcW/nM
	c7lxA/aLgJfsfAoi6pqfqsmWVyS0NCfb+v6pPb8m25wv0hauFXgduT38gEnAHpnDwvGuZIWUl7F
	nisnYsAXehsLbuK9cj+ytEpb0nAiIisgv0eTE7Q==
X-Google-Smtp-Source: AGHT+IGNLx8JB6xk+xWyXk2HDJ+fsPRNSw/Vi9XI30Ea4Oph7Rt3x2FnrP2UfPFyonXifVHwUUb+rzyOKpik39t7AQ0=
X-Received: by 2002:a25:850b:0:b0:dc6:9ce9:e476 with SMTP id
 w11-20020a25850b000000b00dc69ce9e476mr1198634ybk.9.1706611739630; Tue, 30 Jan
 2024 02:48:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Rhys Perry <rhysperry111@gmail.com>
Date: Tue, 30 Jan 2024 10:48:33 +0000
Message-ID: <CAGTBY+uz6kxvM7OEVQUVCyHNnz6APuPgvmQkHBemN1wFkQpiGg@mail.gmail.com>
Subject: TLS session key?
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

Just wondering whether it's possible to get IWD to dump the TLS
session key it uses for EAP on an enterprise network? I'm trying to
debug some odd behavior that some network users are experiencing and
think that there might be some clues in the encrypted messages.

Kind regards,
Rhys
