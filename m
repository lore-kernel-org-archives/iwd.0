Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4425EEEB2
	for <iwd@lists.linux.dev>; Sun, 20 Apr 2025 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745113699; cv=none; b=f4m3AJl06xKeWKZWobwPb1yGrjnoUwOl13IuLArvCS4xs7NvSpXj3esuYgtVktogf1gTV93IVLGCKFnlKxV5E7yGcRvpqfD57AWoWbWSPrQELrDWkmfF0PQ1MsNdoU2pJbLOiSjjI3NwCrUXxl+6B43+OHbRwEZK0NNAXo2OTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745113699; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rXVZQ1XgIkJort99Nbh7AGR4twoL4zanmGIaj+P5tlwVuTWZblVjpIh0RG5bCRMqJUS1LJx5ngEsNhfPu0ZW+GyimtT7T3b0KaQ6Tfa/Ma17PnP9LNz6fUjFt2KhK0tMviayIxb8KJM22/9yGyBrcYQLX4ep47S2Ne3/vrU1Bgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=houseofkodai.in; spf=none smtp.mailfrom=houseofkodai.in; dkim=pass (2048-bit key) header.d=houseofkodai-in.20230601.gappssmtp.com header.i=@houseofkodai-in.20230601.gappssmtp.com header.b=nbtUHXqk; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=houseofkodai.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=houseofkodai.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=houseofkodai-in.20230601.gappssmtp.com header.i=@houseofkodai-in.20230601.gappssmtp.com header.b="nbtUHXqk"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476af5479feso32491201cf.2
        for <iwd@lists.linux.dev>; Sat, 19 Apr 2025 18:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=houseofkodai-in.20230601.gappssmtp.com; s=20230601; t=1745113697; x=1745718497; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=nbtUHXqkfV+Qk2WyhW/K9ITsPdQpthPQrahdkYiYfzN5VsOntdglD9XG8MS+FXghqT
         qU5erriYufcsU3LWW4XkVi0I72NY+3uKn6VHRe52OEAIpGfPWki+VKANTGuUqIIzqV6l
         jkCZiRvu4K4Z1IGStjkl1K0Q/jBnFjhm2o6LO4sq14dDZQfIBIJ2rl/HWwn/9s6hMEn3
         Ll/wZ8dmbVApX6OP91+5ESQEm1azaxg9EF6NW5SS79FRuwbNiHudJ89zB1tZUtwYASgV
         f5RQvIlnDkyYYrdi88PlKwa0FvK5b7lj5LoZgNi/xJALlbNLUSUzvBnKZDlks2D2JHA4
         RXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745113697; x=1745718497;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=IUM58WE2btLinExiBASheJ0eLtvmjAUFGHqZWORsFrchgSHOk3afBvyQPUi4jdi/UA
         E+zRBxvG2jsMeA9UKLSqaARLb28NNZddDlgtd+sN4AFZ+f08o77eLKKPoTJfa2CQ9pbs
         BqL0ES0NOD4au8MAZJW+HyTfZa8/3BSGzM++WtkFj3+ILBBjo5510T7XKCwTrEcYRal8
         8wrYbxBgHdRHZ5x251S6ruTgvs7LQQhXmAkO0QGfnadMYnrwXuXemLOo9J8Z47FHG0VI
         mOcnWgxhIIvTmJmmiNXvG33Aymj/e3r9R6cyql/6i7vDkJY6Par5+Su4Tihv0E2gmUQS
         q4Dg==
X-Gm-Message-State: AOJu0YynB7+ns9SL6EasiR1yTzL/b6Zts/pevhza1ZfFpzOI+TqFNsRx
	9yVGKrdUllL+6LSkAbLZYMPHyE2dCwNEdXixl8CMr6yaeyHmPs5OC4idbFn2o6LskeC2HY/WW0c
	dktOYPzbnQcWPfj+6IpWrrLJNr50Q16/FFR08bRbhRdiJGrHx
X-Gm-Gg: ASbGncsS3Fg0VqsZfEwcbtbu1/rcG93PbMwtYixmhzwXFwqxoZWE2Wc4RBxzcmEzwab
	b6PPIaNFl3RgX+3PEeM3Y+CCbKSaVo3CoA8HhohAPG8eWoNWijjUWb2lmpyRNFNrf0zu7zZk/l/
	C5ylbBwQNs6gswHrA/SlVWqg7u
X-Google-Smtp-Source: AGHT+IGWWmwvDMeJ+DvMio7Ob4aGmQGzyOISHEaxssg0KPl80CX8DnmCZPBgyQ5th8P4Sesd+Az22V1vTaavF3HAOuY=
X-Received: by 2002:a05:6214:2389:b0:6e8:9dc9:1c03 with SMTP id
 6a1803df08f44-6f2c455f647mr134488586d6.21.1745113696848; Sat, 19 Apr 2025
 18:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Karthik Ayyar <karthik@houseofkodai.in>
Date: Sun, 20 Apr 2025 07:18:04 +0530
X-Gm-Features: ATxdqUFtx4U5k5m6M6xsWBrmPI6jjBQoYbuMJqkiL8g4Cx-bRLuBQIWPBVJmpv4
Message-ID: <CAEgrwRcKvfLwjGYE4fK9wtntSqD96ru_dfE5wE68To6YH6gcYg@mail.gmail.com>
Subject: unsubscribe
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"


