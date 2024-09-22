Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F63B8C07
	for <iwd@lists.linux.dev>; Sun, 22 Sep 2024 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727038915; cv=none; b=uB/GCLchEa2KFPJeK7s9+c2iK0nr/8xr7/y3A8t9KlHnJmdAg84bJXII25PsUUXcQhi5Z+NqL36pJP/Je7FWDtdLigo1NFKeEzdEaw4du+aXtwIT4awhMgeBETQnJqWNTTbyHd38LMhPdA+A3TLZ7kCP/IGpTul0IRLbYQR6tKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727038915; c=relaxed/simple;
	bh=P0Dh2nuU2bMC7HDPuxS42MuZy7eIpA4NB27wnadwF5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3jh2etP/S9uCrKzXwOHx6ZbSmDimTZtHsOLJNrJ2TWjemPr9mpe41juVBbzb7oIYhIOoZC75V29jpeKjQt5ivUkhkCxsPh1wcu/kp50C5qlG1f3BA08VI4bVk7LM7Ar1JjYtPzX4tV4ZpNCrrsc7HeRS7zE11zAO6HvVYxzHDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCDEKsp5; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCDEKsp5"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5d5eec95a74so1737908eaf.1
        for <iwd@lists.linux.dev>; Sun, 22 Sep 2024 14:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727038913; x=1727643713; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eTlKfBFqwzoqtwyhGkOa2yGoEFu9lvoxmKJahRSQcAM=;
        b=cCDEKsp5Qz659O7+MeTvi3mt6reD1DUZcxgFy08HSIU1ghuYNsN0Aj9tc2mHHZg/UQ
         ex4BgwO7GmxGKoQ6I+zT8W6VrDNdRgyvoOPsJhqQX3nycMMJq0NEAv4lxw3j13OShDVN
         9tLAyrPp6PChE3KXvhzb37PI09Y1a3otBLl5S8Z5OlZzqe2TUFFPQiWjrJzgHRlzBBvR
         289NPKclSo5K0LOH07qBlCnHav7BkA67nVaryIfU/pp8rKXFFBqrEP02kvISQbHF3XG4
         D96S5eNB87Ft5Uo6YXxPbnUW20qaVwELn7/rmWM4re45YFgHjS9E8/6PLmhCPch5sTDj
         sq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727038913; x=1727643713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTlKfBFqwzoqtwyhGkOa2yGoEFu9lvoxmKJahRSQcAM=;
        b=XPwfvaQDAiRHYQWlrxdjAwUfAWgvLe3r1A0ZSCL3bd6EK48jpEhS6c2Lih+IG7+rEr
         jgnmIrj4McZDr0fevQccbF5wQGEE6eSef4LrNVhxxDjrqyo48Bx4B79TihPjlntFmTbN
         pK9fvsyefDdYMdeQvZKYSn3RII6e6W8+2UKLp+X0ym62MQjpOUTNVcnEvQ1UnmfgCMyh
         K6gqd3W/00TtC85GEsZl/NPANX3fE4oHlp8xirVLXMAJsbHAK/G8eLQQbENam+hkzxA+
         4XDJ9Yvu4CB7o/A12NzDuZplmvzk3/z7MgrHoCM+25TnyRML99fuiX6a0dWLxDX0UQCz
         beZA==
X-Forwarded-Encrypted: i=1; AJvYcCU3IQ26oijyiFMaJAIy2m1O/iZjiMaXIhkpGyW0MmKurpkWpqoaxMwCJYW9K84zAmPNp9A=@lists.linux.dev
X-Gm-Message-State: AOJu0YxH4B67N3Zy+eIzyNWhRdAziibLflPYy4iKkPGF5AlBpZ1yx7jm
	zfSeMT1oOE+qv2gTyg2QGKyp0BXyEHSUEtcpQ9Xcn5LbGGJ6JtLjUpqb6A==
X-Google-Smtp-Source: AGHT+IFzcVUhpzBo/uwQOdo04kxBTb5d7V8DDY8yFAnQga0DuSyFwSZhOe84+LNo7v1SRO1XVn0e9Q==
X-Received: by 2002:a05:6830:71a1:b0:70c:9c66:af53 with SMTP id 46e09a7af769-71392474eb1mr5760355a34.25.1727038913265;
        Sun, 22 Sep 2024 14:01:53 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-71389b48addsm1821673a34.11.2024.09.22.14.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 14:01:52 -0700 (PDT)
Message-ID: <02720419-d2c8-4773-a226-603a46295a1a@gmail.com>
Date: Sun, 22 Sep 2024 16:01:51 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] External Auth support
To: KeithG <ys3al35l@gmail.com>, iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
References: <20240823174220.498594-1-denkenz@gmail.com>
 <CAG17S_PDy_WnhEqD0+EG1zoo99+Y4+2xEzZg2Q=7nPA9Tb9TTw@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAG17S_PDy_WnhEqD0+EG1zoo99+Y4+2xEzZg2Q=7nPA9Tb9TTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 9/22/24 1:56 PM, KeithG wrote:
> It appears that this patch series no longer applies to the current
> git. Is it implemented in iwd or does it need to be refactored to
> apply to the current repo?
> 

I just rebased and resent this series on top of git HEAD.

Regards,
-Denis

