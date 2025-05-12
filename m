Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9097129827D
	for <iwd@lists.linux.dev>; Mon, 12 May 2025 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747074280; cv=none; b=SnGVw8OXB8KABfW1rKzf0BC4G3ofhHB77v351/VF9W3bzJqYsGq+0qhL1QDvCHK6tRm1TJeMmxK8nuDrvaUFv47UQt7OPSbx6YM/pEsbdJF+zE8TNOl6KMIWkZyyDV69ej6SeHvFi8O4eV2ufEku2HnDAQCpH5wv8F6Uw86gDn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747074280; c=relaxed/simple;
	bh=AqY4RBaqynAKEcfTTV49K3npW+WFoOgcekgEGehU9ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCUngnWLwGzGPlS2kUGnOn3Cx7pcX1yUyKl31udsDgB41Q3qL/pK6RcOpKNcq8hqN5Qa2YQExQlnxgAbPoannX9YnulJG6rB0NB0UhY1FRZmGNOhoKMr1oMVzCjOu8KekhkXEypfwXxTEf2em0B0XF1nZwepaKri7ivGRXxgUSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e78fc91f30dso3776614276.3
        for <iwd@lists.linux.dev>; Mon, 12 May 2025 11:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747074277; x=1747679077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqY4RBaqynAKEcfTTV49K3npW+WFoOgcekgEGehU9ZA=;
        b=cFmooHpxhx7YC6O1uVCYgMcNOFw99DW1duluoJ5ZUXz+ESLfWKxLBWJ3GUXJmvitiy
         9sSLvZEegHKZWA6eECEsF1BpoaYafOZ61NCboE0Nwp4LFLP2T2LWthkqHq4eQfsLRteq
         u8CjdU7ICENDpYHnHik5cR0948nCojNZmmRNivblOcRER415rhyaBS3g0/Arr/MKClXv
         9oqfu4pR5VZF1/MvAfm3c/udftcD/tPrx0SbRSjUD2NlGRfUHXIgkEHUSBPIiK0cEJQx
         Qap08Pq1tLYaEDgH9SEOGkvrsdI/pxDv+KIahyHWj6df+mAuGgn1eTmjXw5Q5/jtLC7W
         ZO6Q==
X-Gm-Message-State: AOJu0YyqSrqa0a34+7TTPNKHUpx2kr+VlKdBY7yeRQgSj+TIhusAj+Xw
	fnNNDkYMkOHK9En2YiSmZEKWcOW8iJU9E9xe4ZjPxGm0IqGcGZ40aijxkQ==
X-Gm-Gg: ASbGncso3IZIycH4xP4oVjOttN07IdJ0iUaJiuTZWpJM4Zi7PRQxjzd7Hbwug9wle1/
	RILFd6numpd9X67fLkaKxUc8iLh53gDCRBATBbiVCrcu0amD785hckb+0/fH8731KxkjbYdv3U4
	nFTWPdFJia8FC7Lra1olyBgHQH9+m+Ac8q6pViRctKjtjXQ76SswlCry8BetpFQo06aA2H7CPs5
	/hKzICVpbzH3sPPvXwPkpQTvGIzkpPZoQcYLnnyrhHWyb8XlVv+39k45IWnZmZs0IVijShK2Dq1
	K/ek6CE4sx5L3jffhu/p8OdWAjXeyIHVCydeH9TF4A8deRlZw2aMIWDQYicdG+QpGIGNRs/2Wyj
	n//NJE07c5ZEGfVUGpanUhFMEgBAmdg==
X-Google-Smtp-Source: AGHT+IH3oODx5chqQVKHNG38xphVTYr1BmExsCSuSnSHve7tl61unnwsDy02rGNJ6HDQST/CIkuHtQ==
X-Received: by 2002:a05:690c:4b13:b0:703:ad10:a71b with SMTP id 00721157ae682-70a3fb171c0mr182000217b3.29.1747074277075;
        Mon, 12 May 2025 11:24:37 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70a3d9ecd07sm20241527b3.115.2025.05.12.11.24.36
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 11:24:36 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e78fc91f30dso3776575276.3
        for <iwd@lists.linux.dev>; Mon, 12 May 2025 11:24:36 -0700 (PDT)
X-Received: by 2002:a05:6902:1ac6:b0:e72:6d72:eab8 with SMTP id
 3f1490d57ef6-e78fdc95585mr18734249276.16.1747074276482; Mon, 12 May 2025
 11:24:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADXxVSKPz7o3TT18hCqzz=3MMWrE69NbaBDLSHFBfoRDq5VT7w@mail.gmail.com>
 <d6050f21-98ad-4b1d-a3ca-1d0be7ff7f15@gmail.com>
In-Reply-To: <d6050f21-98ad-4b1d-a3ca-1d0be7ff7f15@gmail.com>
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Mon, 12 May 2025 12:24:25 -0600
X-Gmail-Original-Message-ID: <CADXxVS+kVrO=0rBs7E2sTssP2LNpBQLwGq_anKB80gWvCagTrw@mail.gmail.com>
X-Gm-Features: AX0GCFu4xBXLtYqFLIy5t3lMlOfFubDU4XbRK52VNdiKr8IjT2BirKdMe_lhwds
Message-ID: <CADXxVS+kVrO=0rBs7E2sTssP2LNpBQLwGq_anKB80gWvCagTrw@mail.gmail.com>
Subject: Re: linksys router incorrectly showing as WEP?
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi James,

>
> Could you grab an iwmon pcap of this? Here you can see how the security
> level is determined, and its quite basic:
>

I'll give that a try, unfortunately I didn't have CONFIG_NLMON in the
kernel, I'll add that in now. They are also going to ship me the
problem router so I'll try and repo the issue in person, hopefully a
little more easily.

Thanks!
Bryce
