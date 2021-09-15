Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19E2FAF
	for <iwd@lists.linux.dev>; Wed, 15 Sep 2021 18:26:12 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id bk29so4479295qkb.8
        for <iwd@lists.linux.dev>; Wed, 15 Sep 2021 11:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=PcSZ6JE3kihObY1mhYPtT2/CptLZpy/2COSkLEUaGPY=;
        b=e2XT1oYWRhunqe+apl9WDBwuLWLzxM+SJiFSRXqI2KtdF7RCGXJIIwAM4s2Lh/vDoj
         OJs1jvy0Jy1e2QH9kha1qNrE9c/GqQyxaJVaNe0xX0g/lbkPZAGHBvz8TORVnO3by4KF
         64xI428JkQBoU4tFO0hiVjoOOPz1eGsgW4HPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=PcSZ6JE3kihObY1mhYPtT2/CptLZpy/2COSkLEUaGPY=;
        b=x1cemNq5Or12VCso7vo4u5uD6M7ko8uXc09vKsKPJUcjDBsu9eefEITMOSCAuiEhuG
         TiNgsrttOP++4kPWs/vHvzVp8z1GMAxONMbXI48KnPOHh3YwhtvIIxMHcIKuZiEEKBdp
         zFnlgtdlN75O1XtVFaxj7n5a1HcEKBAiDFruBq0uYkJE+cqyXCxZvX+ObE7E0A9eU1sU
         koMRVSnTg1/GKArZyE8SIuIBwJYzUlXzBcDDlYnlKmsdJK3J2n9PJ+ajbvA+7oThAmSb
         zIF3GsdrXFTUruliN0rzKidL7XCeqcuVuAeLY/f3BDNwvhpuYo7FUuSnX+dzHu5/GBmP
         gVow==
X-Gm-Message-State: AOAM5308/Pol1MLWWzb3L/HWVW+NYVydzq1yMNO8nxErCUKPJorJY24r
	q+PRfmx/gtqhZPMbZVDk7KMa6ZowxirElQ==
X-Google-Smtp-Source: ABdhPJwi6k1CUOwnxg9vdcdYcB9Dp//H/1zMNOhcmB0KDatx1fYkta2nOvd1/ZN+Ejy9CETwI8RHJA==
X-Received: by 2002:ae9:c119:: with SMTP id z25mr1289969qki.201.1631730371848;
        Wed, 15 Sep 2021 11:26:11 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id d20sm446126qtw.53.2021.09.15.11.26.11
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:26:11 -0700 (PDT)
Date: Wed, 15 Sep 2021 14:26:10 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: iwd@lists.linux.dev
Subject: Test delivery to iwd@lists.linux.dev
Message-ID: <20210915182610.4vfhlhurrurcfi5o@meerkat.local>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Testing list archival, please ignore.

-K
