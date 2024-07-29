Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A40145330
	for <iwd@lists.linux.dev>; Mon, 29 Jul 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253322; cv=none; b=sxKsR9LDR8NV5TmEJei3yjCHZ7hqzWvTj3qkI5dMIzGUsivTW7OXQ4it3PEdh8Ae0Ik+xdvbqiSl89TCoYDaEycsMEwRJKpMNxCfj9suBX68yGjVgpQ1vJxG8VBtNDk/iCgIEao2TuP8P+JL/cnV+SVI8M0N5Fkp8lf4GTQdHuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253322; c=relaxed/simple;
	bh=mpiBoG7x4GAqKpXmICIEbVoG0fzjnrM2RnsaE4GOskI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t/ddXZ+fWRHytmkCN5l9CzVudMJ1Iy4XJPgBSFdNk0lgyVjqrr0SJX8t8V0LS8Oqg+wJ4/X0vNSJvbBeRkLjJV9k4kVls52vsgAEzK2m8JVMFYy22vINqTMjt36ko0UVfeysaitFtiDBT39udL5VxipZxojZM1F+xl+lSQdNX6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnHcZNjU; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnHcZNjU"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1dea79e1aso177444885a.1
        for <iwd@lists.linux.dev>; Mon, 29 Jul 2024 04:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722253320; x=1722858120; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yAwFuLeZsCQ/ucfSB/b2mkm4uGx4RfUBClA/qZtaXPg=;
        b=cnHcZNjUP5ZwPxf+ApLElpMA2CA2DLIcX0nb6Wb2HJNGLMsccXI0+bibrUmbxjoA+P
         DnoJZFP26i/CeRxM4S4hfTRXVbqlaKXu5kXc9iL36PH2GjKlDZZ8WsbZqzncWGOxN+YR
         JU4EwN5la33dyZ9e4F7dnYzAf0+CRpD/j3xlD9j1UI/XbJfZNeCn8P2m7QUSWjIOu90M
         TgEAcSbFmmaqb9AMr3FzpIMODDr3HTTYVzs0w24sM2+AovfILTdS5YVBSpdTwH1RYean
         iv2AaCRCwhh7juDS6VRCIOzC8hhDAm7MyrMQUdUcoVWoQefUgV9BqrQbSNeHvIx3mO6h
         vANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722253320; x=1722858120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAwFuLeZsCQ/ucfSB/b2mkm4uGx4RfUBClA/qZtaXPg=;
        b=ZOCc59DzXpfNOtAfUFTHsiTQOYCAfixN5dKix1ZmuISdO7edBgqn7f2iQLIBzf6w/I
         qN4YhjrhfaPLNLLNJoUyveOtiCPu4AXJEhbfiaqL+p5VzZqKr7tZBYTn+a7/JOK2qSzo
         QqVPRjWF/goMotlDma71pBor8TO/WSyE4WhlKFbF6XEomfRXUAx+oRPK3K0qAik8ErwF
         87QNxQl8XHLDNrEFA1s41hdZHHoyFsiAq0HH+X4HXCEw6rl5PHO/m0k84Ur64H+LW6Sd
         W9Yvc81mxFYxbJ2HBTobWMlsBtC7xlPkdlHZHQ/aspqau196w+VJNV3DLuCvTLi73cAF
         RM2w==
X-Forwarded-Encrypted: i=1; AJvYcCW1QjD8cikJNeQfoHRFfIupJn4EzNW9R7jmCCjB/bHdN4zzmpWI5rSdPfvtxEpDXO8oAVv6ZUOm5QgFQ11czmOzE+eW
X-Gm-Message-State: AOJu0YyGNnyk2KbqiaKdPV8pzNO6FkcN6lso4hbi8QnhaM3kUjExGnpe
	LC7t70GTMMBpZvL7Z0zP6NnHdHYq2pKG7qbJpE/4xsyaY1KnOFHoYBSC4g==
X-Google-Smtp-Source: AGHT+IEGa45b6zj/dUZUZ7m1aUVyQ1kG+/6Qo1qVfjkMJpVywDuxw/GIDDOGvWY0CqikF+Rga8JTSg==
X-Received: by 2002:a05:620a:4013:b0:79f:17af:e360 with SMTP id af79cd13be357-7a1e525e9c4mr897325985a.33.1722253320047;
        Mon, 29 Jul 2024 04:42:00 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b383asm514714485a.34.2024.07.29.04.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 04:41:59 -0700 (PDT)
Message-ID: <d592a94c-4e58-40fc-9052-24e13279011e@gmail.com>
Date: Mon, 29 Jul 2024 04:41:57 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wired: Update to the new l_netlink_send API
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240726223754.159303-1-denkenz@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240726223754.159303-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/26/24 3:37 PM, Denis Kenzior wrote:
> ---
>   wired/ethdev.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
All look good to me
