function memo -d "Upgrade pub packages"
  pub global list | awk '{print $1}' | xargs -n1 pub global activate
end
