
library(ggplot2)

# Geometry parameters
tw <- 20                    # horizontal run of each outer valley side
th <- 5                     # height of outer valley side above floodplain
bw <- 0.5                   # horizontal run of each channel bank
bh <- 1                     # channel depth below floodplain
chanwidth <- 2              # flat channel-bottom width
valleywidth <- 25*chanwidth # nominal floodplain + channel width

# Floodplain width on each side
fpw <- (valleywidth - chanwidth) / 2

# Construct the eight vertices
xs <- data.frame(
  point = paste0("P", 1:8),
  x = c(
    0,
    tw,
    tw + fpw,
    tw + fpw + bw,
    tw + fpw + bw + chanwidth,
    tw + fpw + 2 * bw + chanwidth,
    tw + 2 * fpw + 2 * bw + chanwidth,
    2 * tw + 2 * fpw + 2 * bw + chanwidth
  ),
  y = c(
    th,
    0,
    0,
    -bh,
    -bh,
    0,
    0,
    th
  )
)

# Plot
p <- ggplot(xs, aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed", linewidth = 0.4) +
  geom_line(linewidth = 1) +
  geom_point(size = 2.5) +
  # geom_text(
  #   aes(label = point),
  #   nudge_y = 0.35,
  #   size = 3.5,
  #   check_overlap = TRUE
  # ) +
  coord_fixed() +
  labs(
    title = "Raven 8-point compound cross-section",
    # subtitle = paste0(
    #   "tw = ", tw,
    #   ", th = ", th,
    #   ", bw = ", bw,
    #   ", bh = ", bh,
    #   ", valleywidth = ", valleywidth,
    #   ", chanwidth = ", chanwidth,
    #   ", fpw = ", fpw
    # ),
    x = "Chainage",
    y = "Stage"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    plot.title.position = "plot"
  )

print(p)

ggsave(
  filename = "E:/Sync/@owrc/pages/interpolants/modelling/fig/Raven_8_point_cross_section.png",
  plot = p,
  width = 10,
  height = 2.5,
  dpi = 300
)

# # Optional: write the coordinates used in the figure
# write.csv(xs, "Raven_8_point_cross_section_coordinates.csv", row.names = FALSE)







# Geometry parameter
w <- 10

# Construct the four vertices exactly as in the workbook
xs <- data.frame(
  point = paste0("P", 1:4),
  x = c(
    0,
    5 * w + 5,
    6 * w + 5,
    11 * w + 10
  ),
  y = c(5, 0, 0, 5)
)

# Useful derived quantities
side_run <- 5 * w + 5
side_height <- 5
side_slope_HV <- side_run / side_height

# Plot
p <- ggplot(xs, aes(x = x, y = y)) +
  geom_hline(yintercept = 0, linetype = "dashed", linewidth = 0.4) +
  geom_line(linewidth = 1) +
  geom_point(size = 2.5) +
  # geom_text(
  #   aes(label = point),
  #   nudge_y = 0.30,
  #   size = 3.5,
  #   check_overlap = TRUE
  # ) +
  coord_fixed(ratio = 2) +
  labs(
    title = "Raven 4-point trapezoidal cross-section",
    subtitle = "2:1 vertical exaggeration",
    # subtitle = paste0(
    #   "w = ", w,
    #   "; side slope = ", round(side_slope_HV, 2), "H:1V",
    #   "; total width = ", max(xs$x)
    # ),
    x = "Chainage",
    y = "Stage"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    plot.title.position = "plot"
  )

print(p)

ggsave(
  filename = "E:/Sync/@owrc/pages/interpolants/modelling/fig/Raven_4_point_cross_section.png",
  plot = p,
  width = 10,
  height = 2.5,
  dpi = 300
)

# # Optional: write the coordinates used in the figure
# write.csv(xs, "Raven_4_point_cross_section_coordinates.csv", row.names = FALSE)






